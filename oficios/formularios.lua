--[[
	Mod Oficios para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Formulários
  ]]

local S = oficios.S

oficios.form = {}

-- Menu de Escolha
oficios.form.inicial = "size[8,4.5]"..
	default.gui_bg..
	default.gui_bg_img..
	"label[0,0;"..S("Escolha o seu Ofício").."]"..
	-- "button_exit[5,0;3,1;;Escolher depois]"..
	-- Nomes dos Oficios
	"label[0.2,1.1;"..S("Ferreiro").."]"..
	"label[2.2,1.1;"..S("Cientista").."]"..
	"label[4.2,1.1;"..S("Cozinheiro").."]"..
	"label[6.2,1.1;"..S("Construtor").."]"..
	-- Imagens dos Oficios
	"image[0.1,1.5;2,2;oficios_ferreiro.png]"..
	"image[2.1,1.5;2,2;oficios_cientista.png]"..
	"image[4.1,1.5;2,2;oficios_cozinheiro.png]"..
	"image[6.1,1.5;2,2;oficios_construtor.png]"..
	-- Botoes de escolha de Oficio
	"button[0.25,3.3;1.55,1;escolher_ferreiro;"..S("Escolher").."]"..
	"button[2.25,3.3;1.55,1;escolher_cientista;"..S("Escolher").."]"..
	"button[4.25,3.3;1.55,1;escolher_cozinheiro;"..S("Escolher").."]"..
	"button[6.25,3.3;1.55,1;escolher_construtor;"..S("Escolher").."]"

-- Descricao de Ferreiro
oficios.form.desc_ferreiro = "size[9,4.5]"..
	default.gui_bg..
	default.gui_bg_img..
	"label[0.6,0;"..S("Ferreiro").."]"..
	-- Image do Oficio
	"image[0.5,0.5;3,3;oficios_ferreiro.png]"..
	-- Descricao
	"textarea[3.6,0.5;4.4,3.4;;"..S("O Ferreiro pode montar varios itens compostos de metais. Seu foco maior acaba por ser em itens para combate onde pode causar maior dano.")..";]"..
	"label[3.4,0.5;]"..
	"button[1,3.5;3,1;aceitar;"..S("Ser Ferreiro").."]"..
	"button[4,3.5;3,1;voltar;"..S("Voltar").."]"

-- Descricao de Cientista
oficios.form.desc_cientista = "size[9,4.5]"..
	default.gui_bg..
	default.gui_bg_img..
	"label[0.6,0;"..S("Cientista").."]"..
	-- Image do Oficio
	"image[0.5,0.5;3,3;oficios_cientista.png]"..
	-- Descricao
	"textarea[3.6,0.5;4.4,3.4;;"..S("O Cientista possui uma característica especial de montar itens diversificados. Seu foco costuma estar em utilidades nada convencionais que as vezes pode surpreender.")..";]"..
	"button[1,3.5;3,1;aceitar;"..S("Ser Cientista").."]"..
	"button[4,3.5;3,1;voltar;"..S("Voltar").."]"

-- Descricao de Cientista
oficios.form.desc_cozinheiro = "size[9,4.5]"..
	default.gui_bg..
	default.gui_bg_img..
	"label[0.6,0;"..S("Cozinheiro").."]"..
	-- Image do Oficio
	"image[0.5,0.5;3,3;oficios_cozinheiro.png]"..
	-- Descricao
	"textarea[3.6,0.5;4.4,3.4;;"..S("O Cozinheiro consegue perceber o que existe de melhor para comer e prepara sempre bons pratos. Seu enfoque se encontra nos comestíveis.")..";]"..
	"button[1,3.5;3,1;aceitar;"..S("Ser Cozinheiro").."]"..
	"button[4,3.5;3,1;voltar;"..S("Voltar").."]"

-- Descricao de Construtor
oficios.form.desc_construtor = "size[9,4.5]"..
	default.gui_bg..
	default.gui_bg_img..
	"label[0.6,0;"..S("Construtor").."]"..
	-- Image do Oficio
	"image[0.5,0.5;3,3;oficios_construtor.png]"..
	-- Descricao
	"textarea[3.6,0.5;4.4,3.4;;"..S("O Construtor sempre sabe como erguer uma bela estrutura seja qual for o material ou necessidade. Seu enfoque vai em itens para estruturar.")..";]"..
	"button[1,3.5;3,1;aceitar;"..S("Ser Construtor").."]"..
	"button[4,3.5;3,1;voltar;"..S("Voltar").."]"

-- Aviso de falta de itens
oficios.form.aviso_falta_item = "size[6,2]"..
	default.gui_bg..
	default.gui_bg_img..
	"textarea[1,1;6.4,2;;"..S("Precisa ter os itens requisitados para iniciar a montagem.")..";]"..
	"button_exit[3,3;2,1;voltar_ao_item;"..S("Voltar").."]"

-- Aviso de falta espaco no inventario
oficios.form.aviso_inv_lotado = "size[6,2]"..
	default.gui_bg..
	default.gui_bg_img..
	"textarea[1,1;6.4,2;;"..S("Inventário lotado. Esvazie um pouco.")..";]"..
	"button_exit[3,3;2,1;voltar_ao_item;"..S("Voltar").."]"

-- Aviso de nivel insuficiente
oficios.form.aviso_nivel_insuficiente = "size[6,2]"..
	default.gui_bg..
	default.gui_bg_img..
	"textarea[1,1;6.4,2;;"..S("Nível muito baixo. Precisa ter um nível maior para montar esse item.")..";]"..
	"button_exit[3,3;2,1;voltar_ao_item;"..S("Voltar").."]"

-- Aviso de falta de receitas em algum oficio
oficios.form.aviso_sem_receita = "size[6,2]"..
	default.gui_bg..
	default.gui_bg_img..
	"textarea[1,1;6.4,2;;"..S("Falta receita em algum ofício. Precisa existir ao menos uma receita para cada ofício.")..";]"



