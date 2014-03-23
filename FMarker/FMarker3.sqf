/*
	File Name: FMarker3.sqf
	File Created: 12/29/2013
	File Version: 1.1
	File Author: Foamy 
	File Last Edit Date: 3/23/2014
	File Description: Foamy's Marker System for M3 Missions

	Variables:
	1. Marker Pos
	2. Loot Pos
	3. Marker Radius
	4. Marker Color
	5. Debug - True or False
	
	Example:
	[_position,_loot_pos,_markerRadius,_markerColor,false] execVM "\z\addons\dayz_server\addons\FMission\FMarker\FMarker3.sqf";
*/

private ["_loop", "_color", "_coords", "_radius", "_event_marker", "_start_time", "_lootcords", "_debug_marker", "_debug"];

diag_log("FMarker 3: Loading Script");

_coords = _this select 0;
_lootcoords = _this select 1;
_radius = _this select 2;
_color = _this select 3;
_debug = _this select 4;

_start_time = time;

if (_debug) then
{
while{EPOCH_MISSION3_RUNNING} do
	{
	_event_marker3 = createMarker [ format ["loot_event_marker_%1", _start_time], _coords];
	_event_marker3 setMarkerShape "ELLIPSE";
	_event_marker3 setMarkerColor _color;
	_event_marker3 setMarkerAlpha 0.5;
	_event_marker3 setMarkerSize [(_radius + 50), (_radius + 50)];

	_debug_marker3 = createMarker [ format ["loot_event_debug_marker_%1", _start_time], _lootcoords];
	_debug_marker3 setMarkerShape "ICON";
	_debug_marker3 setMarkerType "mil_dot";
	_debug_marker3 setMarkerColor _color;
	_debug_marker3 setMarkerAlpha 1;
	sleep 15;
	deleteMarker _debug_marker3;
	deleteMarker _event_marker3;
	};
};

if (!_debug) then	
{
while{EPOCH_MISSION3_RUNNING} do
	{
	_event_marker3 = createMarker [ format ["loot_event_marker_%1", _start_time], _coords];
	_event_marker3 setMarkerShape "ELLIPSE";
	_event_marker3 setMarkerColor _color;
	_event_marker3 setMarkerAlpha 0.5;
	_event_marker3 setMarkerSize [(_radius + 50), (_radius + 50)];
	sleep 15;
	deleteMarker _event_marker3;
	};
};
diag_log("FMarker 3: Closing Script");