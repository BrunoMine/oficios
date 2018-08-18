--[[
	Mod Oficios_Basicos para Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Cozinheiro
  ]]

local S = oficios_basicos.S

-- Bolinho Selvagem
minetest.register_craftitem("oficios_basicos:bolinho_simples", {
	description = S("Bolinho Simples"),
	inventory_image = "oficios_basicos_bolinho_selvagem.png",
	wield_image = "oficios_basicos_bolinho_selvagem_na_mao.png",
	wield_scale = 4,
	stack_max = 20,
	on_use = minetest.item_eat(5),
})

-- Registrando receita 
local itens_requeridos = {
	{"farming:flour", 1},
	{"default:apple", 1}
}
local desc = S("Um singelo bolinho perfeito para a um lanche de tardinha.")
oficios.montar_receita(
	"cozinheiro", -- Nome do oficio
	"oficios_basicos:bolinho_simples", -- Item a ser criado
	1, -- Nivel requerido
	desc, -- Descricao
	5, -- XP recebido
	itens_requeridos, -- Itens requeridos
	{00,00,05} -- Tempo
)
