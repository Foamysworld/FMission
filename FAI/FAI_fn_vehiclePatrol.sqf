//scriptName "Functions\spawning\fn_taskPatrol.sqf";
/*
	File: taskPatrol.sqf
	Author: Joris-Jan van 't Land

	Description:
	Create a random patrol of several waypoints around a given position.

	Parameter(s):
	_this select 0: the group to which to assign the waypoints (Group)
	_this select 1: the position on which to base the patrol (Array)
	_this select 2: the maximum distance between waypoints (Number)
	_this select 3: (optional) blacklist of areas (Array)
	
	Returns:
	Boolean - success flag
	
	Customized by Foamy for FMission
	
*/

//Validate parameter count
if ((count _this) < 3) exitWith {diag_log "Log: [taskPatrol] Function requires at least 3 parameters!"; false};

private ["_grp", "_pos", "_maxDist", "_blacklist"];
_grp = _this select 0;
_pos = _this select 1;
_maxDist = _this select 2;

_blacklist = [];
if ((count _this) > 3) then {_blacklist = _this select 3};

//Validate parameters
if ((typeName _grp) != (typeName grpNull)) exitWith {diag_log "Log: [taskPatrol] Group (0) must be a Group!"; false};
if ((typeName _pos) != (typeName [])) exitWith {diag_log "Log: [taskPatrol] Position (1) must be an Array!"; false};
if ((typeName _maxDist) != (typeName 0)) exitWith {diag_log "Log: [taskPatrol] Maximum distance (2) must be a Number!"; false};
if ((typeName _blacklist) != (typeName [])) exitWith {diag_log "Log: [taskPatrol] Blacklist (3) must be an Array!"; false};

_grp setBehaviour "SAFE";

//Create a string of randomly placed waypoints.
private ["_prevPos"];
_prevPos = _pos;
for "_i" from 0 to (2 + (floor (random 3))) do
{
	private ["_vwp", "_newPos"];
	_newPos = [_prevPos, 50, _maxDist, 1, 0, 60 * (pi / 180), 0, _blacklist] call BIS_fnc_findSafePos;
	_prevPos = _newPos;

	_vwp = _grp addWaypoint [_newPos, 0];
	_vwp setWaypointType "MOVE";
	_vwp setWaypointCompletionRadius 20;

	//Set the group's speed and formation at the first waypoint.
	if (_i == 0) then
	{
		_vwp setWaypointSpeed "LIMITED";
		_vwp setWaypointFormation "STAG COLUMN";
	};
};

//Cycle back to the first position.
private ["_vwp"];
_vwp = _grp addWaypoint [_pos, 0];
_vwp setWaypointType "CYCLE";
_vwp setWaypointCompletionRadius 20;

true