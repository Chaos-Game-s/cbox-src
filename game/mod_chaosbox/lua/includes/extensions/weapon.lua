--[[
	Original code by Team Sandbox:
		Copyleft © 2010 - 2013, Team Sandbox, Some rights reserved.

	Modified for Experiment.
--]]

_R.CBaseCombatWeapon.__WeaponSound = _R.CBaseCombatWeapon.WeaponSound
local WeaponSound = _R.CBaseCombatWeapon.WeaponSound
local gpGlobals = gpGlobals

-- HACKHACK: We override this here, because for some reason scripted weapons
-- don't properly play weapon sounds in singleplayer
function _R.CBaseCombatWeapon.WeaponSound( self, sound_type, soundtime )
  if ( CLIENT ) then
    return
  end

  -- Only the player fires this way so we can cast
  local client = self:GetOwner()

  -- if ( gpGlobals.maxClients() > 1 ) then
  --   WeaponSound( self, sound_type, soundtime )
  -- else
    local shootsound = self:GetShootSound( sound_type )
    if ( ToBaseEntity( client ) ~= NULL ) then
      client:EmitSound( shootsound )
    else
      self:EmitSound( shootsound )
    end
  -- end
end