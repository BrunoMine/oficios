--[[
	Mod Oficios para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Formulários
  ]]

oficios.form = {}

-- Menu de Escolha
oficios.form.inicial = "size[8,4.5]"..
	default.gui_bg..
	default.gui_bg_img..
	"label[0,0;Escolha o seu Oficio]"..
	"button_exit[5,0;3,1;;Escolher depois]"..
	-- Nomes dos Oficios
	"label[0.2,1.1;Ferreiro]"..
	"label[2.2,1.1;Cientista]"..
	"label[4.2,1.1;Cozinheiro]"..
	"label[6.2,1.1;Construtor]"..
	-- Imagens dos Oficios
	"image[0.1,1.5;2,2;oficios_ferreiro.png]"..
	"image[2.1,1.5;2,2;oficios_cientista.png]"..
	"image[4.1,1.5;2,2;oficios_cozinheiro.png]"..
	"image[6.1,1.5;2,2;oficios_construtor.png]"..
	-- Botoes de escolha de Oficio
	"button[0.25,3.3;1.55,1;escolher_ferreiro;Escolher]"..
	"button[2.25,3.3;1.55,1;escolher_cientista;Escolher]"..
	"button[4.25,3.3;1.55,1;escolher_cozinheiro;Escolher]"..
	"button[6.25,3.3;1.55,1;escolher_construtor;Escolher]"

-- Descricao de Ferreiro
oficios.form.desc_ferreiro = "size[9,4.5]"..
	default.gui_bg..
	default.gui_bg_img..
	"label[1.4,0;FERREIRO]"..
	-- Image do Oficio
	"image[1.1,0.5;3,3;oficios_ferreiro.png]"..
	-- Descricao
	"label[4,0.5;O Ferreiro pode montar "..
	"\nvarios itens compostos de "..
	"\nmetais. "..
	"\nSeu foco maior acaba por ser "..
	"\nem itens para combate onde "..
	"\npode causar maior dano. ]"..
	"label[2.2,4.3;SUA ESCOLHA NAO TEM VOLTA]"..
	"button[1.5,3.5;3,1;aceitar;Ser Ferreiro]"..
	"button[4.5,3.5;3,1;voltar;Voltar]"

-- Descricao de Cientista
oficios.form.desc_cientista = "size[9,4.5]"..
	default.gui_bg..
	default.gui_bg_img..
	"label[1.4,0;CIENTISTA]"..
	-- Image do Oficio
	"image[1.1,0.5;3,3;oficios_cientista.png]"..
	-- Descricao
	"label[4,0.5;O Cientista possui uma "..
	"\ncaracteristica especial de "..
	"\nmontar itens diversificados. "..
	"\nSeu foco costuma estar em "..
	"\nutilidades nada convensionais "..
	"\nque as vezes pode surpreender. ]"..
	"label[2.2,4.3;SUA ESCOLHA NAO TEM VOLTA]"..
	"button[1.5,3.5;3,1;aceitar;Ser Cientista]"..
	"button[4.5,3.5;3,1;voltar;Voltar]"

-- Descricao de Cientista
oficios.form.desc_cozinheiro = "size[9,4.5]"..
	default.gui_bg..
	default.gui_bg_img..
	"label[1.4,0;COZINHEIRO]"..
	-- Image do Oficio
	"image[1.1,0.5;3,3;oficios_cozinheiro.png]"..
	-- Descricao
	"label[4,0.5;O Cozinheiro consegue "..
	"\nperceber o que existe de "..
	"\nmelhor para comer e prepara "..
	"\nsempre bons pratos. "..
	"\nSeu enfoque se encontra nos "..
	"\ncomestiveis. ]"..
	"label[2.2,4.3;SUA ESCOLHA NAO TEM VOLTA]"..
	"button[1.5,3.5;3,1;aceitar;Ser Cozinheiro]"..
	"button[4.5,3.5;3,1;voltar;Voltar]"

-- Descricao de Construtor
oficios.form.desc_construtor = "size[9,4.5]"..
	default.gui_bg..
	default.gui_bg_img..
	"label[1.4,0;CONSTRUTOR]"..
	-- Image do Oficio
	"image[1.1,0.5;3,3;oficios_construtor.png]"..
	-- Descricao
	"label[4,0.5;O Construtor sempre sabe "..
	"\ncomo erguer uma bela "..
	"\nestrutura seja qual for "..
	"\no material ou necessidade. "..
	"\nSeu enfoque vai em itens"..
	"\npara estruturar. ]"..
	"label[2.2,4.3;SUA ESCOLHA NAO TEM VOLTA]"..
	"button[1.5,3.5;3,1;aceitar;Ser Construtor]"..
	"button[4.5,3.5;3,1;voltar;Voltar]"

-- Aviso de falta de itens
oficios.form.aviso_falta_item = "size[6,2]"..
	default.gui_bg..
	default.gui_bg_img..
	"label[0,0;Precisar ter os itens requisitados \npara iniciar a montagem]"..
	"button_exit[2,1;2,1;voltar_ao_item;Voltar]"

-- Aviso de falta espaco no inventario
oficios.form.aviso_inv_lotado = "size[6,2]"..
	default.gui_bg..
	default.gui_bg_img..
	"label[0,0;Inventario lotado \nEsvazie um pouco]"..
	"button_exit[2,1;2,1;voltar_ao_item;Voltar]"

-- Aviso de nivel insuficiente
oficios.form.aviso_nivel_insuficiente = "size[6,2]"..
	default.gui_bg..
	default.gui_bg_img..
	"label[0,0;Nivel muito baixo. Precisa ter um \nnivel maior para montar esse item]"..
	"button_exit[2,1;2,1;voltar_ao_item;Voltar]"

-- Aviso de falta de receitas em algum oficio
oficios.form.aviso_sem_receita = "size[6,2]"..
	default.gui_bg..
	default.gui_bg_img..
	"label[0,0;Faltam receitas e algum oficios \nPrecisa existir ao menos uma receita \npara cada oficio]"



