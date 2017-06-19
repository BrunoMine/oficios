--[[
	Mod Oficios para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Funcoes
  ]]





--
-----
--------
-- Montar Receitas
-- Ordenar vetor
local ordenar_por_nivel = function(vetor, lim)
	local i = 1
	local j = 1
	while (i <= lim) do
		j = i + 1
		while (j <= lim) do
			if (tonumber(vetor[i].nivel) > tonumber(vetor[j].nivel)) then
				local aux = vetor[i]
				vetor[i] = vetor[j]
				vetor[j] = aux
			end
			j = j + 1
		end
		i = i + 1
	end
	return vetor
end
-- Vetores de niveis
local vetor_niveis = {["ferreiro"]={},["cientista"]={},["cozinheiro"]={},["construtor"]={}}
-- Listas
local lista_receitas = {["ferreiro"]="",["cientista"]="",["cozinheiro"]="",["construtor"]=""}
-- Tabela de relacionamento IDItem-NomeItem
local tabela_IDNome = {}
-- Tabela de relacionamento de sequencia NomeItem-IDItem
local dropdown_NomeID = {["ferreiro"]={},["cientista"]={},["cozinheiro"]={},["construtor"]={}}
oficios.montar_receita = function(oficio, item, nivel, desc, xp, item_requisitado, tempo)

	-- Inserindo novos dados nas tabelas
	oficios.receitas[minetest.registered_items[item].description] = {
		item=item, 
		nivel=nivel, 
		desc=desc, 
		xp=xp, 
		item_requisitado=item_requisitado, 
		tempo=tempo
	}
	table.insert(vetor_niveis[oficio], {nivel=nivel, nome=minetest.registered_items[item].description, item=item})	
	tabela_IDNome["(Nivel "..nivel..") "..minetest.registered_items[item].description]={
		item_id=item,
		item_nome_real=minetest.registered_items[item].description
	}

	-- Calcular maior indice da tabela
	local lim = table.maxn(vetor_niveis[oficio])

	-- Ordenar
	vetor_niveis[oficio] = ordenar_por_nivel(vetor_niveis[oficio], lim)

	-- Escrever lista
	lista_receitas[oficio] = "(Nivel "..vetor_niveis[oficio][1].nivel..") "..vetor_niveis[oficio][1].nome
	dropdown_NomeID[oficio]["(Nivel "..vetor_niveis[oficio][1].nivel..") "..vetor_niveis[oficio][1].nome]=1
	local i = 2
	while (i <= lim) do
		dropdown_NomeID[oficio]["(Nivel "..vetor_niveis[oficio][i].nivel..") "..vetor_niveis[oficio][i].nome]=i
		lista_receitas[oficio] = lista_receitas[oficio]..",(Nivel "..vetor_niveis[oficio][i].nivel..") "..vetor_niveis[oficio][i].nome
		i = i + 1
	end
end
-- Fim de Montar Receitas
--------
-----
--



--
-----
--------
-- Receptor de Botoes
local receita_visualizada = {}
local visualizando_desc = {}
minetest.register_on_player_receive_fields(function(player, formname, fields)
	
	-- Menu de Escolha
	if formname == "oficios:menu_de_escolha" then
		local name = player:get_player_name()
		if fields.escolher_ferreiro then
			minetest.show_formspec(name, "oficios:desc_ferreiro", oficios.form.desc_ferreiro)
		elseif fields.escolher_cientista then
			minetest.show_formspec(name, "oficios:desc_cientista", oficios.form.desc_cientista)
		elseif fields.escolher_cozinheiro then
			minetest.show_formspec(name, "oficios:desc_cozinheiro", oficios.form.desc_cozinheiro)
		elseif fields.escolher_construtor then
			minetest.show_formspec(name, "oficios:desc_construtor", oficios.form.desc_construtor)
		end
	end

	--
	-- Menus de Descricao
	--
	if formname == "oficios:desc_ferreiro" 
		or formname == "oficios:desc_cientista"
		or formname == "oficios:desc_cozinheiro"
		or formname == "oficios:desc_construtor" 
	then
		local name = player:get_player_name()
		if fields.voltar then
			minetest.show_formspec(name, "oficios:menu_de_escolha", oficios.form.inicial)
		elseif fields.aceitar then
			if formname == "oficios:desc_ferreiro" then
				oficios.bd.definir_oficio(name, "ferreiro")
				oficios.gerar_menu_oficio(name)
			elseif formname == "oficios:desc_cientista" then
				oficios.bd.definir_oficio(name, "cientista")
				oficios.gerar_menu_oficio(name)
			elseif formname == "oficios:desc_cozinheiro" then
				oficios.bd.definir_oficio(name, "cozinheiro")
				oficios.gerar_menu_oficio(name)
			elseif formname == "oficios:desc_construtor" then
				oficios.bd.definir_oficio(name, "construtor")
				oficios.gerar_menu_oficio(name)
			end
		end
	end

	--
	-- Painel do Oficio
	--
	if formname == "oficios:menu_ferreiro"
		or formname == "oficios:menu_cientista"
		or formname == "oficios:menu_cozinheiro"
		or formname == "oficios:menu_construtor"
	then
		local name = player:get_player_name()
		
		-- Atualizar painel
		local n = 0 -- Verificar se o jogador apenas mudou o dropdown
		for campo,item in pairs(fields) do
			n = n + 1
		end
		if n == 1 and fields.item_selecionado then
			receita_visualizada[name] = fields.item_selecionado
			oficios.gerar_menu_oficio(name, fields.item_selecionado)
		end
		
		
		-- voltar
		if fields.voltar then
			oficios.gerar_menu_oficio(name)
		end
		-- voltar ao item
		if fields.voltar_ao_item then
			visualizando_desc[name] = false
			oficios.gerar_menu_oficio(name, receita_visualizada[name])
		end
		
		-- Ver descricao
		if fields.desc then
			visualizando_desc[name] = true
			oficios.gerar_menu_oficio(name, receita_visualizada[name])
		end
		-- Coletar
		if fields.coletar then
			if player:get_inventory():room_for_item("main", registros_oficios[name].coletar) then
				player:get_inventory():add_item("main", registros_oficios[name].coletar)
				oficios.bd.coletou_item(name)
				oficios.gerar_menu_oficio(name)
			else
				return minetest.show_formspec(name, "oficios:aviso_montagem", oficios.form.aviso_inv_lotado)
			end
			
		end

		-- Iniciar montagem
		if fields.iniciar then
			local dados = oficios.receitas[tabela_IDNome[receita_visualizada[name]].item_nome_real]
			-- Verifica o nivel
			if registros_oficios[name].nivel < dados.nivel then
				return minetest.show_formspec(name, "oficios:aviso_montagem", oficios.form.aviso_nivel_insuficiente)
			else
				
				local player_inv = player:get_inventory()


				-- Verificar se possui os itens
				local possui_itens = true
				for _, valor in ipairs(dados.item_requisitado) do
					if player_inv:contains_item("main", valor[1].." "..valor[2]) == false then
						possui_itens = false
					end
				end
				if possui_itens == false then
					return minetest.show_formspec(name, "oficios:aviso_montagem", oficios.form.aviso_falta_item)
				end
				
				-- Retirar itens
				for _, valor in ipairs(dados.item_requisitado) do
					player_inv:remove_item("listname", valor[1].." "..valor[2])
				end
				
				-- Calcular Data fim
				local data_atual = os.date("%Y %m %d %H %M")
				data_atual = string.split(data_atual, " ")
				local data_fim = {tonumber(data_atual[1]), tonumber(data_atual[2]), (tonumber(data_atual[3])+dados.tempo[1]), (tonumber(data_atual[4])+dados.tempo[2]), (tonumber(data_atual[5])+dados.tempo[3])}
				if data_fim[5] >= 60 then 
					data_fim[4] = data_fim[4] + 1
					data_fim[5] = data_fim[5] - 60
				end
				if data_fim[4] >= 24 then 
					data_fim[3] = data_fim[3] + 1
					data_fim[4] = data_fim[4] - 24
				end
				if data_fim[3] > 30 then 
					data_fim[2] = data_fim[2] + 1
					data_fim[3] = data_fim[3] - 30
				end
				if data_fim[2] > 12 then 
					data_fim[1] = data_fim[1] + 1
					data_fim[2] = data_fim[2] - 12
				end
			
				
				-- Iniciar tarefa no banco de dados
				oficios.bd.iniciar_montagem(name, tabela_IDNome[receita_visualizada[name]].item_nome_real, data_fim)

				return oficios.gerar_menu_oficio(name)
			end
		end
	end
	
	-- Retorno dos avisos de montagem
	if formname == "oficios:aviso_montagem" then
		local name = player:get_player_name()
		
		if fields.voltar_ao_item then
			return oficios.gerar_menu_oficio(name, receita_visualizada[name])
		end
	end
	
end)
-- Fim do Receptor de Botoes
--------
-----
--




--
-----
--------
-- Gerar Menu de Oficio
-- Calcular_termino (retorna true se terminou caso contrario retorna quantos minutos faltam)
local calcular_se_terminou = function(data_fim)
	local data_atual = os.date("%Y %m %d %H %M")
	data_atual = string.split(data_atual, " ")
	local total_atual = (tonumber(data_atual[1])*518400) + (tonumber(data_atual[2])*43200) + (tonumber(data_atual[3])*1440) + (tonumber(data_atual[4])*60) + tonumber(data_atual[5])
	local total_fim = (data_fim[1]*518400) + (data_fim[2]*43200) + (data_fim[3]*1440) + (data_fim[4]*60) + data_fim[5]
	local resultado = total_fim - total_atual
	if resultado > 0 then
		return resultado
	else
		return true
	end
end
oficios.gerar_menu_oficio = function(name, item_nome)
	local oficio = registros_oficios[name].oficio
	local formspec = ""
	if item_nome == nil then

		if registros_oficios[name].montagem.status == true then
			local item_id = oficios.receitas[registros_oficios[name].montagem.item].item
			
			-- Verificar se a data termino ja passou
			local data_fim = registros_oficios[name].montagem.data_fim
			local dias, horas, minutos = oficios.comparar_data(data_fim[1], data_fim[2], data_fim[3], data_fim[4], data_fim[5])
			
			if dias < 0 or horas < 0 or minutos < 0 or dias+horas+minutos == 0 then
			
				-- Dar xp/ concluir
				oficios.bd.conluir_montagem(name, oficios.receitas[registros_oficios[name].montagem.item].xp)	
				
				-- Iniciar novo processo de geracao do menu
				oficios.gerar_menu_oficio(name)
				return

			else
				
				-- Pegando valores absolutos
				dias, horas, minutos = math.abs(dias), math.abs(horas), math.abs(minutos)
				
				-- Calcular tempo restante
				local tempo = {dias,horas,minutos}
				local tempo_escrito = ""
				if tempo[1] > 0 then
					if tempo[1] == 1 then
						tempo[1] = tempo[1].." dia"
					else
						tempo[1] = tempo[1].." dias"
					end
				end
				if tempo[2] > 0 then
					if tempo[2] == 1 then
						tempo[2] = tempo[2].." hora"
					else
						tempo[2] = tempo[2].." horas"
					end
				end
				if tempo[3] > 0 then
					if tempo[3] == 1 then
						tempo[3] = tempo[3].." minuto"
					else
						tempo[3] = tempo[3].." minutos"
					end
				end
				
				if dias > 0 and horas > 0 then
					tempo_escrito = tempo[1].." e "..tempo[2]
				else
					if horas > 0 and minutos > 0 then
						tempo_escrito = tempo[2].." e "..tempo[3]
					else
						if dias > 0 then
							tempo_escrito = tempo[1]
						else
							if horas > 0 then
								tempo_escrito = tempo[2]
							else
								tempo_escrito = tempo[3]
							end
						end
					end
				end
				
				-- Gerar Painel de esperar
				formspec = "size[8,8.5]"..
					default.gui_bg..
					default.gui_bg_img..
					default.gui_slots..
					"list[current_player;main;0,4.25;8,1;]"..
					"list[current_player;main;0,5.5;8,3;8]"..
					default.get_hotbar_bg(0,4.25)..
					-- Cabecalho do Oficio
					"image[0,0;2.5,2.5;oficios_"..oficio..".png]"..
					"label[2.2,-0.1;"..string.upper(oficio).." Nivel "..registros_oficios[name].nivel.."]"..
					-- Painel de espera
					"label[4.3,0.6;Montando \n"..registros_oficios[name].montagem.item..
					"\n\nTermina em \n"..tempo_escrito.."]"..
					"item_image_button[2.2,0.6;2,2;"..item_id..";;]"..
					-- Botao sair
					"button_exit[6.9,3.3;1.2,1;;Sair]"	
				
			end

		else
		
			if registros_oficios[name].coletar == "" then
	

				-- Gerar painel normal
				local xp_prox_nivel = OFICIOS_NIVEIS[(registros_oficios[name].nivel+1)]
				formspec = "size[8,8.5]"..
					default.gui_bg..
					default.gui_bg_img..
					default.gui_slots..
					"list[current_player;main;0,4.25;8,1;]"..
					"list[current_player;main;0,5.5;8,3;8]"..
					default.get_hotbar_bg(0,4.25)..
					-- Cabecalho do Oficio
					"image[0,0;2.5,2.5;oficios_"..oficio..".png]"..
					"label[2.2,-0.1;"..string.upper(oficio).." Nivel "..registros_oficios[name].nivel.."]"..
					-- Botao sair
					"button_exit[6.9,3.3;1.2,1;;Sair]"..
					-- Painel de Montagem
					"dropdown[2.2,0.35;6.15,1;item_selecionado;"..lista_receitas[oficio]..";]"..
					"label[2.2,1.1;Selecione algo para produzir]"
				-- Calcular e inserir dados de desempenho 
				formspec = formspec .. "label[0.2,2.3;Seu Desempenho \nAtualmente "..registros_oficios[name].xp.." XP "
				if registros_oficios[name].nivel < LIMITE_DE_NIVEL then
					formspec = formspec .. "\nProximo Nivel "..xp_prox_nivel.." XP"
				end
				formspec = formspec .. "\nTotal de "..registros_oficios[name].total_itens.." itens montados]"
	
			else

				-- Gerar painel para coletar item
				formspec = "size[8,8.5]"..
					default.gui_bg..
					default.gui_bg_img..
					default.gui_slots..
					"list[current_player;main;0,4.25;8,1;]"..
					"list[current_player;main;0,5.5;8,3;8]"..
					default.get_hotbar_bg(0,4.25)..
					-- Cabecalho do Oficio
					"image[0,0;2.5,2.5;oficios_"..oficio..".png]"..
					"label[2.2,-0.1;"..string.upper(oficio).." Nivel "..registros_oficios[name].nivel.."]"..
					-- Painel de conclusao
					"label[2.3,0.4;"..minetest.registered_items[registros_oficios[name].coletar].description.."]"..
					"label[5.2,1;Montado]"..
					"item_image_button[2.2,1;3,3;"..registros_oficios[name].coletar..";coletar;Coletar]"..
					-- Botao sair
					"button_exit[6.9,3.3;1.2,1;;Sair]"

			end
		end

	else

		if visualizando_desc[name] == true then
			-- Gerar painel descritivo de um item
			local item_nome_real = tabela_IDNome[receita_visualizada[name]].item_nome_real
			local dados = oficios.receitas[item_nome_real]
			formspec = formspec .. "size[8,8.8]"..
				default.gui_bg..
				default.gui_bg_img..
				default.gui_slots..
				"list[current_player;main;0,4.75;8,1;]"..
				"list[current_player;main;0,6;8,3;8]"..
				default.get_hotbar_bg(0,4.75)..
				-- Cabecalho do Oficio
				"image[0,0;2.5,2.5;oficios_"..oficio..".png]"..
				"label[2.2,-0.1;"..string.upper(oficio).." Nivel "..registros_oficios[name].nivel.."]"..
				-- Dados sobre a Montagem
				"label[2.2,1.1;"..item_nome_real.."]"..
				"item_image_button[0.1,2.5;2,2;"..dados.item..";item;]"..
				-- descricao
				"label[2.2,1.7;"..dados.desc.."]"..
				-- Botao voltar
				"button[6.9,3.3;1.2,1;voltar_ao_item;Voltar]"..
				-- Painel de Montagem
				"dropdown[2.2,0.35;6.15,1;item_selecionado;"..lista_receitas[oficio]..";"..dropdown_NomeID[oficio][receita_visualizada[name]].."]"

		else

	 		-- Gerar um Painel de montagem de um item
			local item_id = tabela_IDNome[item_nome].item_id
			local item_nome_real = tabela_IDNome[item_nome].item_nome_real
			local item_requisitado = oficios.receitas[item_nome_real].item_requisitado
			-- Colocando itens requisitados
			formspec = formspec .. "size[8,8.8]"..
				default.gui_bg..
				default.gui_bg_img..
				default.gui_slots..
				"list[current_player;main;0,4.75;8,1;]"..
				"list[current_player;main;0,6;8,3;8]"..
				default.get_hotbar_bg(0,4.75)..
				"label[2.2,3.1;Itens requisitados]"
			if item_requisitado[1] ~= nil then
				formspec = formspec .. "item_image_button[2.2,3.5;1,1;"..item_requisitado[1][1].." "..item_requisitado[1][2]..";item_req1;]"
			end
			if item_requisitado[2] ~= nil then
				formspec = formspec .. "item_image_button[3.1,3.5;1,1;"..item_requisitado[2][1].." "..item_requisitado[2][2]..";item_req2;]"
			end
			if item_requisitado[3] ~= nil then
				formspec = formspec .. "item_image_button[4.0,3.5;1,1;"..item_requisitado[3][1].." "..item_requisitado[3][2]..";item_req3;]"
			end
			if item_requisitado[4] ~= nil then
				formspec = formspec .. "item_image_button[4.9,3.5;1,1;"..item_requisitado[4][1].." "..item_requisitado[4][2]..";item_req4;]"
			end
			if item_requisitado[5] ~= nil then
				formspec = formspec .. "item_image_button[5.8,3.5;1,1;"..item_requisitado[5][1].." "..item_requisitado[5][2]..";item_req5;]"
			end
			if item_requisitado[6] ~= nil then
				formspec = formspec .. "item_image_button[6.7,3.5;1,1;"..item_requisitado[6][1].." "..item_requisitado[6][2]..";item_req6;]"
			end
			-- Colocando Tempo de montagem
			local tempo = oficios.receitas[item_nome_real].tempo
			formspec = formspec .. "label[2.2,1.6;Tempo estimado \n"
			if tempo[1] > 0 then
				if tempo[1] == 1 then
					formspec = formspec .. tempo[1].." dia" 
				else
					formspec = formspec .. tempo[1].." dias"
				end
				if tempo[2] > 0 then
					if tempo[2] == 1 then
						formspec = formspec .. " e "..tempo[2].." hora"
					else
						formspec = formspec .. " e "..tempo[2].." horas"
					end
				end
			elseif tempo[2] > 0 then
				if tempo[2] == 1 then
					formspec = formspec .. tempo[2].." hora" 
				else
					formspec = formspec .. tempo[2].." horas"
				end
				if tempo[3] > 0 then
					if tempo[3] == 1 then
						formspec = formspec .. " e "..tempo[3].." minuto"
					else
						formspec = formspec .. " e "..tempo[3].." minutos"
					end
				end
			else
				if tempo[3] == 1 then
					formspec = formspec .. tempo[3].." minuto"
				else
					formspec = formspec .. tempo[3].." minutos"
				end
			end
			formspec = formspec .. "]"
			
			formspec = formspec .. 
				-- Cabecalho do Oficio
				"image[0,0;2.5,2.5;oficios_"..oficio..".png]"..
				"label[2.2,-0.1;"..string.upper(oficio).." Nivel "..registros_oficios[name].nivel.."]"..
				-- Painel de Montagem
				"dropdown[2.2,0.35;6.15,1;item_selecionado;"..lista_receitas[oficio]..";"..dropdown_NomeID[oficio][item_nome].."]"..
				-- Dados sobre a Montagem
				"label[2.2,1.1;Montar "..item_nome_real.."]"..
				"item_image_button[0.1,2.5;2,2;"..item_id..";iniciar;Iniciar]"..
				"label[2.2,2.5;Recebe "..core.colorize("#00FF00", oficios.receitas[item_nome_real].xp.." XP").."]"..
				"image_button[7,1.3;1,1;oficios_botao_desc.png;desc;]"..
				-- Botao voltar
				"button[6.9,2.3;1.2,1;voltar;Voltar]"
		end

	end

	minetest.show_formspec(name, "oficios:menu_"..oficio, formspec)
end
-- Fim de Gerar Menu de Oficio
--------
-----
--


-- Abrir o menu de oficios
local acesso_ok = false -- variavel que informa se todos os oficios possuem receitas (para evitar bugs)
oficios.abrir_menu = function(name)
	
	if acesso_ok == false then
		-- Verifica se ja todos oficios possuem receita
		if table.maxn(vetor_niveis.ferreiro) > 0 
			and table.maxn(vetor_niveis.cozinheiro) > 0 
			and table.maxn(vetor_niveis.cientista) > 0 
			and table.maxn(vetor_niveis.construtor) > 0 
		then
			acesso_ok = true
		else
			-- Bloqueia o acesso
			return minetest.show_formspec(name, "oficios:aviso_sem_receita", oficios.form.aviso_sem_receita)
		end
	end
	
	if registros_oficios[name].oficio == "ferreiro" 
		or registros_oficios[name].oficio == "cientista" 
		or registros_oficios[name].oficio == "cozinheiro"
		or registros_oficios[name].oficio == "construtor"
	then
		oficios.gerar_menu_oficio(name)
	else
		minetest.show_formspec(name, "oficios:menu_de_escolha", oficios.form.inicial)
	end
end
