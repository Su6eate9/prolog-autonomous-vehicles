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

% EXERCÍCIO 2: INTERAÇÃO COM LEITURA DE SENSORES
% Definição dos Sensores Disponíveis
sensor(temperatura_motor).
sensor(tensao_bateria).
sensor(nivel_oleo).
sensor(rotacao_motor).
sensor(pressao_oleo).
sensor(temperatura_ar_admissao).

% Limites Críticos dos Sensores
limite_critico(temperatura_motor, maximo, 100).
limite_critico(tensao_bateria, minimo, 12.0).
limite_critico(nivel_oleo, minimo, 20).
limite_critico(rotacao_motor, minimo, 700).
limite_critico(rotacao_motor, maximo, 6500).
limite_critico(pressao_oleo, minimo, 1.0).

% Estado Atual dos Sensores (simulação)
leitura_sensor(temperatura_motor, 105).
leitura_sensor(tensao_bateria, 11.5).
leitura_sensor(nivel_oleo, 15).
leitura_sensor(rotacao_motor, 850).
leitura_sensor(pressao_oleo, 0.8).

% Regras de Inferência para Diagnóstico de Sensores
sensor_critico(Sensor, Valor, Problema) :-
    leitura_sensor(Sensor, Valor),
    limite_critico(Sensor, minimo, LimiteMin),
    Valor < LimiteMin,
    problema_sensor_baixo(Sensor, Problema).

sensor_critico(Sensor, Valor, Problema) :-
    leitura_sensor(Sensor, Valor),
    limite_critico(Sensor, maximo, LimiteMax),
    Valor > LimiteMax,
    problema_sensor_alto(Sensor, Problema).

% Mapeamento de Sensores para Problemas
problema_sensor_baixo(tensao_bateria, bateria_fraca).
problema_sensor_baixo(nivel_oleo, nivel_oleo_baixo).
problema_sensor_baixo(rotacao_motor, rotacao_instavel).
problema_sensor_baixo(pressao_oleo, bomba_oleo_defeituosa).

problema_sensor_alto(temperatura_motor, superaquecimento).
problema_sensor_alto(rotacao_motor, rotacao_excessiva).

% SISTEMA DE DIAGNÓSTICO PRINCIPAL
% Regras de Diagnóstico Combinado
diagnostico(Problema, Probabilidade, Componente) :-
    sensor_critico(_, _, Problema),
    causa(_, Problema, Probabilidade),
    componente_relacionado(Problema, Componente).

diagnostico(Problema, Probabilidade, Componente) :-
    sintoma(Sintoma),
    sintoma_presente(Sintoma),
    causa(Sintoma, Problema, Probabilidade),
    componente_relacionado(Problema, Componente).

% Mapeamento de Problemas para Componentes
componente_relacionado(bateria_fraca, bateria).
componente_relacionado(alternador_defeituoso, alternador).
componente_relacionado(vela_ignicao_defeituosa, velas_ignicao).
componente_relacionado(sensor_virabrequim_defeituoso, sensor_virabrequim).
componente_relacionado(sistema_injecao_falho, sistema_injecao).
componente_relacionado(nivel_oleo_baixo, sistema_lubrificacao).
componente_relacionado(superaquecimento, sistema_arrefecimento).
componente_relacionado(bomba_agua_defeituosa, bomba_agua).
componente_relacionado(radiador_obstruido, radiador).
componente_relacionado(correia_acessorios_rompida, correia_acessorios).

% Sintomas Presentes (simulação de entrada do usuário)
sintoma_presente(falha_ignicao).
sintoma_presente(luz_bateria_acesa).
sintoma_presente(barulho_incomum_motor).

% AÇÕES CORRETIVAS SUGERIDAS
acao_corretiva(bateria_fraca, 'Verificar conexões da bateria e testar carga. Substituir se necessário.').
acao_corretiva(alternador_defeituoso, 'Testar saída do alternador. Substituir se defeituoso.').
acao_corretiva(vela_ignicao_defeituosa, 'Verificar estado das velas de ignição e substituir.').
acao_corretiva(nivel_oleo_baixo, 'Verificar nível de óleo e completar. Investigar possível vazamento.').
acao_corretiva(superaquecimento, 'Verificar nível do líquido de arrefecimento e funcionamento do radiador.').
acao_corretiva(bomba_agua_defeituosa, 'Testar funcionamento da bomba d\'água e substituir se necessário.').
acao_corretiva(sistema_injecao_falho, 'Executar diagnóstico do sistema de injeção eletrônica.').
acao_corretiva(correia_acessorios_rompida, 'Verificar estado da correia e substituir se rompida ou desgastada.').

% SISTEMA DE CONSULTA E RELATÓRIOS
% Consulta Principal de Diagnóstico
executar_diagnostico :-
    write('=== SISTEMA DE DIAGNÓSTICO AUTOMOTIVO ==='), nl, nl,
    write('ANÁLISE DE SENSORES:'), nl,
    mostrar_sensores_criticos,
    nl,
    write('DIAGNÓSTICO BASEADO EM SINTOMAS:'), nl,
    mostrar_diagnosticos,
    nl,
    write('AÇÕES CORRETIVAS RECOMENDADAS:'), nl,
    mostrar_acoes_corretivas.

% Mostrar Sensores em Estado Crítico
mostrar_sensores_criticos :-
    sensor_critico(Sensor, Valor, Problema),
    format('- Sensor ~w: Valor ~w - Indica: ~w~n', [Sensor, Valor, Problema]),
    fail.
mostrar_sensores_criticos.

% Mostrar Diagnósticos
mostrar_diagnosticos :-
    diagnostico(Problema, Probabilidade, Componente),
    format('- Problema: ~w | Probabilidade: ~w | Componente: ~w~n', 
           [Problema, Probabilidade, Componente]),
    fail.
mostrar_diagnosticos.

% Mostrar Diagnósticos Baseados em Sintomas
mostrar_diagnosticos :-
    sintoma(Sintoma),
    sintoma_presente(Sintoma),
    causa(Sintoma, Problema, Probabilidade),
    componente_relacionado(Problema, Componente),
    format('- Sintoma: ~w | Problema: ~w | Probabilidade: ~w | Componente: ~w~n', 
           [Sintoma, Problema, Probabilidade, Componente]),
    fail.

% Mostrar Diagnósticos Baseados em Sensores
mostrar_diagnosticos :-
    sensor_critico(Sensor, Valor, Problema),
    diagnostico(Problema, Probabilidade, Componente),
    format('- Sensor: ~w | Problema: ~w | Probabilidade: ~w | Componente: ~w~n', 
           [Sensor, Problema, Probabilidade, Componente]),
    fail.

% Mostrar Ações Corretivas
mostrar_acoes_corretivas :-
    diagnostico(Problema, alta, _),
    acao_corretiva(Problema, Acao),
    format('- ~w: ~w~n', [Problema, Acao]),
    fail.

mostrar_acoes_corretivas :-
    diagnostico(Problema, media, _),
    acao_corretiva(Problema, Acao),
    format('- ~w: ~w~n', [Problema, Acao]),
    fail.

mostrar_acoes_corretivas :-
    diagnostico(Problema, baixa, _),
    acao_corretiva(Problema, Acao),
    format('- ~w: ~w~n', [Problema, Acao]),
    fail.

mostrar_acoes_corretivas.