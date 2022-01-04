--[[
	Mod Oficios para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Banco de Dados
  ]]

oficios.bd = {}

-- Mod storage
local mod_storage = minetest.get_mod_storage()

-- Variavel de registros
registros_oficios = {}

-- Carregar registros de oficios salvos
--local path = minetest.get_worldpath() .. "/oficios"
-- Cria o diretorio caso nao exista ainda
--local function mkdir(path)
--	if minetest.mkdir then
--		minetest.mkdir(path)
--	else
--		os.execute('mkdir "' .. path .. '"')
--	end
--end
--mkdir(path)

-- Carrega dados na tabela quando o jogador conecta
minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	
	registros_oficios[name] = minetest.deserialize(mod_storage:get_string("player:"..name))
	
	--local input = io.open(path .. "/oficios_"..name, "r")
	--if input then
	--	registros_oficios[name] = minetest.deserialize(input:read("*l"))
	--	io.close(input)
	--end
end)

-- Retira da memoria quando o jogador sai
minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	registros_oficios[name] = nil
end)

-- Salvar registros de oficios
oficios.bd.salvar = function(name)
	mod_storage:set_string("player:"..name, minetest.serialize(registros_oficios[name]))
	--local output = io.open(path .. "/oficios_"..name, "w")
	--output:write(minetest.serialize(registros_oficios[name]))
	--io.close(output)
end

-- Inserir registro
oficios.bd.inserir = function(name)
	if not name then
		minetest.log("error", "[Oficios]: variavel name invalida (name = "..dump(name)..")")
		return false
	end
	registros_oficios[name] = {
		oficio = "nenhum", -- Tipo de Ofício
		nivel = 1, -- Nível
		xp = 0, -- Quantidade de experiencia
		montagem = {
			status = false, -- Se está montando
			item = "", -- Nome do item que está sendo montado
			data_fim = 0 -- Data de termino da montagem
		},
		total_itens = 0, -- Total de itens feitos
		coletar = "" -- Item a coletar
	}
	oficios.bd.salvar(name)
end

-- Coletou o item
oficios.bd.coletou_item = function(name)
	registros_oficios[name].coletar = ""
	oficios.bd.salvar(name)
end

-- Iniciar montagem
oficios.bd.iniciar_montagem = function(name, item, data_fim)
	registros_oficios[name].montagem.status = true
	registros_oficios[name].montagem.item = item
	registros_oficios[name].montagem.data_fim = data_fim
	oficios.bd.salvar(name)
end

-- Concluir montagem
oficios.bd.conluir_montagem = function(name, xp)
	registros_oficios[name].montagem.status = false
	registros_oficios[name].coletar = oficios.receitas[registros_oficios[name].montagem.item].item
	registros_oficios[name].montagem.item = ""
	registros_oficios[name].montagem.data_fim = 0
	registros_oficios[name].total_itens = registros_oficios[name].total_itens + 1
	if (registros_oficios[name].xp + xp) > LIMITE_DE_XP then
		registros_oficios[name].xp = LIMITE_DE_XP
	else
		registros_oficios[name].xp = registros_oficios[name].xp + xp
	end
	-- atualizar nivel
	local nivel_atual = 1
	if registros_oficios[name].xp == LIMITE_DE_XP then
		nivel_atual = LIMITE_DE_NIVEL
	else
		while registros_oficios[name].xp >= OFICIOS_NIVEIS[nivel_atual+1] do
			nivel_atual = nivel_atual + 1
		end
	end
	registros_oficios[name].nivel = nivel_atual
	oficios.bd.salvar(name)
end

-- Definir Oficio
oficios.bd.definir_oficio = function(name, oficio)
	registros_oficios[name].oficio = oficio
	oficios.bd.salvar(name)
end

-- Aumentar experiencia
oficios.bd.aumentar_xp = function(name, valor)
	if (registros_oficios[name].xp + valor) > LIMITE_DE_XP then
		registros_oficios[name].xp = LIMITE_DE_XP
	else
		registros_oficios[name].xp = registros_oficios[name].xp + valor
	end
	-- atualizar nivel
	local nivel_atual = 1
	if registros_oficios[name].xp == LIMITE_DE_XP then
		nivel_atual = LIMITE_DE_NIVEL
	else
		while registros_oficios[name].xp >= OFICIOS_NIVEIS[nivel_atual+1] do
			nivel_atual = nivel_atual + 1
		end
	end
	registros_oficios[name].nivel = nivel_atual
	oficios.bd.salvar(name)
end

-- Diminuir experiencia
oficios.bd.diminuir_xp = function(name, valor)
	if registros_oficios[name].xp < valor then
		registros_oficios[name].xp = 0
	else
		registros_oficios[name].xp = registros_oficios[name].xp - valor
	end
	-- atualizar nivel
	local nivel_atual = 1
	if registros_oficios[name].xp == LIMITE_DE_XP then
		nivel_atual = LIMITE_DE_NIVEL
	else
		while registros_oficios[name].xp >= OFICIOS_NIVEIS[nivel_atual+1] do
			nivel_atual = nivel_atual + 1
		end
	end
	registros_oficios[name].nivel = nivel_atual
	oficios.bd.salvar(name)
end

-- Registra apenas novos jogadores
minetest.register_on_newplayer(function(player)
	local name = player:get_player_name()
	oficios.bd.inserir(name)
end)


