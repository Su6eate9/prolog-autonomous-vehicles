% SISTEMA DE DIAGNÓSTICO AUTOMOTIVO EM PROLOG

% EXERCÍCIO 1: ESTRUTURA BÁSICA DE DIAGNÓSTICO
% Base de Conhecimento: Sintomas Básicos
sintoma(falha_ignicao).
sintoma(check_engine_acesa).
sintoma(luz_bateria_acesa).
sintoma(barulho_incomum_motor).
sintoma(superaquecimento).
sintoma(perda_potencia).
sintoma(consumo_excessivo_combustivel).

% Possíveis Causas para cada Sintoma
% Falha de Ignição
causa(falha_ignicao, bateria_fraca, alta).
causa(falha_ignicao, vela_ignicao_defeituosa, media).
causa(falha_ignicao, sensor_virabrequim_defeituoso, media).
causa(falha_ignicao, sistema_injecao_falho, baixa).
causa(falha_ignicao, bobina_ignicao_defeituosa, media).

% Check Engine Acesa
causa(check_engine_acesa, sensor_oxigenio_defeituoso, alta).
causa(check_engine_acesa, sistema_injecao_falho, alta).
causa(check_engine_acesa, catalisador_obstruido, media).
causa(check_engine_acesa, sensor_maf_defeituoso, media).
causa(check_engine_acesa, vazamento_vacuo, baixa).

% Luz de Bateria Acesa
causa(luz_bateria_acesa, alternador_defeituoso, alta).
causa(luz_bateria_acesa, correia_acessorios_rompida, alta).
causa(luz_bateria_acesa, bateria_fraca, media).
causa(luz_bateria_acesa, fusivel_queimado, baixa).

% Barulho Incomum no Motor
causa(barulho_incomum_motor, nivel_oleo_baixo, alta).
causa(barulho_incomum_motor, bomba_agua_defeituosa, media).
causa(barulho_incomum_motor, tensor_correia_frouxo, media).
causa(barulho_incomum_motor, rolamento_defeituoso, baixa).

% Superaquecimento
causa(superaquecimento, nivel_oleo_baixo, alta).
causa(superaquecimento, radiador_obstruido, alta).
causa(superaquecimento, bomba_agua_defeituosa, media).
causa(superaquecimento, termostato_defeituoso, media).
causa(superaquecimento, sensor_temperatura_defeituoso, baixa).
