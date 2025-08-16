import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/ride_destination.dart';

class GoogleCampusMapPicker extends StatefulWidget {
  final List<RideDestination> destinations;
  final RideDestination? selected;
  final ValueChanged<RideDestination> onChanged;
  final double height;

  const GoogleCampusMapPicker({
    super.key,
    required this.destinations,
    required this.selected,
    required this.onChanged,
    this.height = 180,
  });

  @override
  State<GoogleCampusMapPicker> createState() => _GoogleCampusMapPickerState();
}

class _GoogleCampusMapPickerState extends State<GoogleCampusMapPicker> {
  final _controller = Completer<GoogleMapController>();
  late CameraPosition _initial;
  Set<Marker> _markers = const <Marker>{};

  @override
  void initState() {
    super.initState();
    // Default camera somewhere around DFW
    _initial = const CameraPosition(target: LatLng(32.90, -97.20), zoom: 9.8);
    _markers = widget.destinations.map((d) {
      final sel = widget.selected?.id == d.id;
      return Marker(
        markerId: MarkerId(d.id),
        position: LatLng(d.lat, d.lng),
        infoWindow: InfoWindow(title: d.name, snippet: d.address),
        icon: sel ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)
            : BitmapDescriptor.defaultMarker,
        onTap: () => widget.onChanged(d),
      );
    }).toSet();
  }

  @override
  void didUpdateWidget(covariant GoogleCampusMapPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update marker color when selection changes
    _markers = widget.destinations.map((d) {
      final sel = widget.selected?.id == d.id;
      return Marker(
        markerId: MarkerId(d.id),
        position: LatLng(d.lat, d.lng),
        infoWindow: InfoWindow(title: d.name, snippet: d.address),
        icon: sel ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)
            : BitmapDescriptor.defaultMarker,
        onTap: () => widget.onChanged(d),
      );
    }).toSet();
    _maybeAnimateToSelected();
  }

  Future<void> _fitToAll() async {
    if (_markers.isEmpty || !_controller.isCompleted) return;
    final c = await _controller.future;
    // Build bounds around all markers
    final lats = _markers.map((m) => m.position.latitude).toList();
    final lngs = _markers.map((m) => m.position.longitude).toList();
    final sw = LatLng(lats.reduce((a, b) => a < b ? a : b), lngs.reduce((a, b) => a < b ? a : b));
    final ne = LatLng(lats.reduce((a, b) => a > b ? a : b), lngs.reduce((a, b) => a > b ? a : b));
    final bounds = LatLngBounds(southwest: sw, northeast: ne);
    final update = CameraUpdate.newLatLngBounds(bounds, 64);
    await c.animateCamera(update);
  }

  Future<void> _maybeAnimateToSelected() async {
    if (widget.selected == null || !_controller.isCompleted) return;
    final c = await _controller.future;
    await c.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(widget.selected!.lat, widget.selected!.lng), 13.0),
    );
  }

  bool get _mapLikelyAvailable {
    // Simple heuristic: if we’re on web, trust the plugin (meta key required).
    // On mobile, assume available; if key missing, plugin shows its own error UI.
    if (kIsWeb) return true;
    // On emulators/simulators, Maps require proper SDKs & key; still attempt.
    if (Platform.isIOS || Platform.isAndroid) return true;
    // Other platforms -> fall back
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (!_mapLikelyAvailable) {
      return _fallback(context, 'Map preview (platform not supported here)');
    }
    return Container(
      height: widget.height,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 0.6, color: Theme.of(context).dividerColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: GoogleMap(
        initialCameraPosition: _initial,
        mapToolbarEnabled: false,
        zoomControlsEnabled: true,
        myLocationButtonEnabled: false,
        markers: _markers,
        onMapCreated: (ctrl) async {
          if (!_controller.isCompleted) _controller.complete(ctrl);
          // Fit to all campuses on first render
          await Future.delayed(const Duration(milliseconds: 200));
          await _fitToAll();
          // If one is selected, animate to it
          await _maybeAnimateToSelected();
        },
        onTap: (_) {}, // taps are handled via markers
      ),
    );
  }

  Widget _fallback(BuildContext context, String message) {
    return Container(
      height: widget.height,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 0.6, color: Theme.of(context).dividerColor),
      ),
      child: Center(child: Text(message, textAlign: TextAlign.center)),
    );
  }
}
