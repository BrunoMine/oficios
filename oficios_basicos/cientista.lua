--[[
	Mod Oficios_Basicos para Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Cientista
  ]]

local S = oficios_basicos.S

-- formspec do Bau Expandido
local bau_formspec =
	"size[10,8.5]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"list[current_name;main;0,0;10,4;]"..
	"list[current_player;main;1,4.3;8,1;]"..
	"list[current_player;main;1,5.4.08;8,3;8]"..
	"listring[current_name;main]"..
	"listring[current_player;main]"

-- Bau Expandido
minetest.register_node("oficios_basicos:bau_expandido", {
	description = S("Bau Expandido"),
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_front.png"},
	paramtype2 = "facedir",
	groups = {choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_wood_defaults(),

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", bau_formspec)
		meta:set_string("infotext", S("Bau Expandido"))
		local inv = meta:get_inventory()
		inv:set_size("main", 10*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,

})

-- Registrando receita de Bau Expandido
local itens_requeridos = {
	{"default:wood", 30},
	{"default:steel_ingot", 2}
}
local desc = S("Esse baú cabe mais coisas do que imagina. Perfeito para colocar tralhas.")
oficios.montar_receita(
	"cientista", -- Nome do oficio
	"oficios_basicos:bau_expandido", -- Item a ser criado
	1, -- Nivel requerido
	desc, -- Descricao
	25, -- XP recebido
	itens_requeridos, -- Itens requeridos
	{00,00,20} -- Tempo
)

-- Mosquete
if minetest.get_modpath("musket") then

	-- Registrando receita de Mosquete
	local itens_requeridos = {
		{"default:steel_ingot", 3},
		{"default:junglewood", 3},
		{"musket:ammo_mosquete", 1},
	}
	local desc = S("Esse belo mosquete consegue atingir um alvo a 20 blocos de distância.")
	oficios.montar_receita(
		"cientista", -- Nome do oficio
		"musket:mosquete", -- Item a ser criado
		5, -- Nivel requerido
		desc, -- Descricao
		200, -- XP recebido
		itens_requeridos, -- Itens requeridos
		{01,00,00} -- Tempo
	)
end
