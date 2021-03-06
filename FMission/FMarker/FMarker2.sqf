/*
	File Name: FMarker2.sqf
	File Created: 12/29/2013
	File Version: 1.3
	File Author: Foamy 
	File Last Edit Date: 3/27/2014
	File Description: Foamy's Marker System for M2 Missions

	Variables:
	1. Marker Pos
	2. Loot Pos
	3. Marker Radius
	4. Marker Color
	5. Debug - True or False
	6. Text Icon Type "Icon Type for Text Marker" https://community.bistudio.com/wiki/cfgMarkers
	7. Marker Text "Text to display on Marker"
	8. Marker Brush ("SOLID","HORIZONTAL","VERTICAL","GRID","FDIAGONAL","BDIAGONAL","DIAGRID","CROSS","BORDER","SOLIDBORDER")
	
Example:
[_position,_loot_pos,_markerRadius,_markerColor,false,_textMarker_IconType,_markerText,_markerBrush] execVM "\z\addons\dayz_server\addons\FMission\FMarker\FMarker2.sqf";
*/

private ["_loop","_color","_coords","_radius","_event_marker","_start_time","_lootcords","_debug_marker","_debug","_text_icon_type","_text","_brush","_event_marker2","_text_marker2","_debug_marker2"];

diag_log("FMarker 2: Loading Script");

_coords = _this select 0;
_lootcoords = _this select 1;
_radius = _this select 2;
_color = _this select 3;
_debug = _this select 4;
_text_icon_type = _this select 5;
_text = _this select 6;
_brush = _this select 7;

_start_time = time;

if (_debug) then
{
while{EPOCH_MISSION2_RUNNING} do
	{
	_event_marker2 = createMarker [ format ["loot_event_marker_%1", _start_time], _coords];
	_event_marker2 setMarkerShape "ELLIPSE";
	_event_marker2 setMarkerColor _color;
	_event_marker2 setMarkerAlpha 0.5;
	_event_marker2 setMarkerSize [(_radius + 50), (_radius + 50)];
	_event_marker2 setMarkerBrush _brush;
	
	_text_marker2 = createMarker [ format ["loot_event_debug_marker_%1", _start_time], _coords];
	_text_marker2 setMarkerShape "ICON";
	_text_marker2 setMarkerType _text_icon_type;
	_text_marker2 setMarkerColor "ColorBlack";
	_text_marker2 setMarkerText _text;
	_text_marker2 setMarkerAlpha .75;

	_debug_marker2 = createMarker [ format ["loot_event_debug_marker_%1", _start_time], _lootcoords];
	_debug_marker2 setMarkerShape "ICON";
	_debug_marker2 setMarkerType "mil_dot";
	_debug_marker2 setMarkerColor _color;
	_debug_marker2 setMarkerAlpha 1;
	sleep 15;
	deleteMarker _event_marker2;
	deleteMarker _text_marker2;
	deleteMarker _debug_marker2;
	};
};

if (!_debug) then	
{
while{EPOCH_MISSION2_RUNNING} do
	{
	_event_marker2 = createMarker [ format ["loot_event_marker_%1", _start_time], _coords];
	_event_marker2 setMarkerShape "ELLIPSE";
	_event_marker2 setMarkerColor _color;
	_event_marker2 setMarkerAlpha 0.5;
	_event_marker2 setMarkerSize [(_radius + 50), (_radius + 50)];
	_event_marker2 setMarkerBrush _brush;
	
	_text_marker2 = createMarker [ format ["loot_event_debug_marker_%1", _start_time], _coords];
	_text_marker2 setMarkerShape "ICON";
	_text_marker2 setMarkerType _text_icon_type;
	_text_marker2 setMarkerColor "ColorBlack";
	_text_marker2 setMarkerText _text;
	_text_marker2 setMarkerAlpha .75;
	
	sleep 15;
	deleteMarker _event_marker2;
	deleteMarker _text_marker2;
	};
};
diag_log("FMarker 2: Closing Script");