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
    .
leitura_sensor(Sensor, Valor),
limite_critico(Sensor, minimo, LimiteMin),
Valor < LimiteMin,
problema_sensor_baixo(Sensor, Problema).

sensor_critico(Sensor, Valor, Problema) :-
    .
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
    .
sensor_critico(_, _, Problema),
causa(_, Problema, Probabilidade),
componente_relacionado(Problema, Componente).

diagnostico(Problema, Probabilidade, Componente) :-
    .
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
    .
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
    .
sensor_critico(Sensor, Valor, Problema),
format('- Sensor ~w: Valor ~w - Indica: ~w~n', [Sensor, Valor, Problema]),
fail.
mostrar_sensores_criticos.

% Mostrar Diagnósticos
mostrar_diagnosticos :-
    .
diagnostico(Problema, Probabilidade, Componente),
format('- Problema: ~w | Probabilidade: ~w | Componente: ~w~n',
[Problema, Probabilidade, Componente]),
fail.
mostrar_diagnosticos.

% Mostrar Diagnósticos Baseados em Sintomas
mostrar_diagnosticos :-
    .
sintoma(Sintoma),
sintoma_presente(Sintoma),
causa(Sintoma, Problema, Probabilidade),
componente_relacionado(Problema, Componente),
format('- Sintoma: ~w | Problema: ~w | Probabilidade: ~w | Componente: ~w~n',
[Sintoma, Problema, Probabilidade, Componente]),
fail.

% Mostrar Diagnósticos Baseados em Sensores
mostrar_diagnosticos :-
    .
sensor_critico(Sensor, Valor, Problema),
diagnostico(Problema, Probabilidade, Componente),
format('- Sensor: ~w | Problema: ~w | Probabilidade: ~w | Componente: ~w~n',
[Sensor, Problema, Probabilidade, Componente]),
fail.

% Mostrar Ações Corretivas
mostrar_acoes_corretivas :-
    .
diagnostico(Problema, alta, _),
acao_corretiva(Problema, Acao),
format('- ~w: ~w~n', [Problema, Acao]),
fail.

mostrar_acoes_corretivas :-
    .
diagnostico(Problema, media, _),
acao_corretiva(Problema, Acao),
format('- ~w: ~w~n', [Problema, Acao]),
fail.

mostrar_acoes_corretivas :-
    .
diagnostico(Problema, baixa, _),
acao_corretiva(Problema, Acao),
format('- ~w: ~w~n', [Problema, Acao]),
fail.

mostrar_acoes_corretivas.

% EXERCÍCIO 3: REGRAS DE DECISÃO E PRIORIZAÇÃO
% Sistema de Pesos para Priorização
peso_probabilidade(alta, 3).
peso_probabilidade(media, 2).
peso_probabilidade(baixa, 1).

% Cenários de Conflito - Múltiplos sintomas apontando para diferentes causas
cenario_conflito(1, [falha_ignicao, luz_bateria_acesa], 'Conflito elétrico').
cenario_conflito(2, [superaquecimento, barulho_incomum_motor], 'Conflito mecânico').
cenario_conflito(3, [check_engine_acesa, perda_potencia], 'Conflito sistema injeção').

% Regra de Priorização com Corte para Evitar Backtracking Desnecessário
diagnostico_prioritario(Problema, Probabilidade, Componente, Pontuacao) :-
    .
diagnostico(Problema, Probabilidade, Componente),
peso_probabilidade(Probabilidade, Peso),
contar_sintomas_relacionados(Problema, ContadorSintomas),
Pontuacao is Peso * ContadorSintomas,
!. % Corte para evitar backtracking após encontrar solução

% Conta quantos sintomas estão relacionados a um problema específico
contar_sintomas_relacionados(Problema, Contador) :-
    .
findall(Sintoma, (causa(Sintoma, Problema, _), sintoma_presente(Sintoma)), Lista),
length(Lista, Contador).

% Encontrar o diagnóstico com maior pontuação (mais provável)
melhor_diagnostico(MelhorProblema, MelhorProbabilidade, MelhorComponente, MaiorPontuacao) :-
    .
findall(pontuacao(Problema, Probabilidade, Componente, Pontuacao),
diagnostico_prioritario(Problema, Probabilidade, Componente, Pontuacao),
ListaPontuacoes),
encontrar_maior_pontuacao(ListaPontuacoes, MelhorProblema, MelhorProbabilidade, MelhorComponente, MaiorPontuacao).

% Encontra a maior pontuação na lista
encontrar_maior_pontuacao([pontuacao(P, Prob, C, Pont)], P, Prob, C, Pont) :-
    !..
encontrar_maior_pontuacao([pontuacao(P1, Prob1, C1, Pont1)|Resto], MelhorP, MelhorProb, MelhorC, MaiorPont) :-
    .
encontrar_maior_pontuacao(Resto, P2, Prob2, C2, Pont2),
(Pont1 > Pont2 ->
(MelhorP = P1, MelhorProb = Prob1, MelhorC = C1, MaiorPont = Pont1) ;
(MelhorP = P2, MelhorProb = Prob2, MelhorC = C2, MaiorPont = Pont2)).

% Análise de Conflitos entre Sintomas
analisar_conflito(NumCenario) :-
    .
cenario_conflito(NumCenario, Sintomas, Descricao),
format('=== ANÁLISE DE CONFLITO: ~w ===~n', [Descricao]),
format('Sintomas presentes: ~w~n~n', [Sintomas]),
analisar_sintomas_conflito(Sintomas),
nl,
write('RESOLUÇÃO POR PRIORIZAÇÃO:'), nl,
melhor_diagnostico(MelhorProblema, MelhorProb, MelhorComp, MaiorPont),
format('Diagnóstico mais provável: ~w (~w) - Componente: ~w - Pontuação: ~w~n',
[MelhorProblema, MelhorProb, MelhorComp, MaiorPont]).

% Analisa cada sintoma no conflito
analisar_sintomas_conflito([]).
analisar_sintomas_conflito([Sintoma|Resto]) :-
    .
format('Sintoma: ~w~n', [Sintoma]),
findall(causa_info(Problema, Prob), causa(Sintoma, Problema, Prob), Causas),
mostrar_causas(Causas),
nl,
analisar_sintomas_conflito(Resto).

% Mostra as causas de um sintoma
mostrar_causas([]).
mostrar_causas([causa_info(Problema, Prob)|Resto]) :-
    .
format('  -> ~w (probabilidade: ~w)~n', [Problema, Prob]),
mostrar_causas(Resto).

% Sistema com Backtracking Controlado para Múltiplas Soluções
diagnosticos_alternativos(ListaDiagnosticos) :-
    .
findall(diagnostico_info(Problema, Probabilidade, Componente, Pontuacao),
diagnostico_prioritario(Problema, Probabilidade, Componente, Pontuacao),
ListaTodos),
sort(4, @>=, ListaTodos, ListaOrdenada), % Ordena por pontuação decrescente
ListaDiagnosticos = ListaOrdenada.

% EXERCÍCIO 4: AÇÕES CORRETIVAS AVANÇADAS
% Sistema Expandido de Ações Corretivas
% Ações Primárias (Alta Prioridade)
acao_corretiva_primaria(bateria_fraca, 'Testar tensão da bateria com multímetro').
acao_corretiva_primaria(alternador_defeituoso, 'Verificar saída do alternador (13.5-14.4V em funcionamento)').
acao_corretiva_primaria(nivel_oleo_baixo, 'Verificar nível de óleo na vareta e completar se necessário').
acao_corretiva_primaria(superaquecimento, 'Verificar nível do líquido de arrefecimento e temperatura do radiador').
acao_corretiva_primaria(vela_ignicao_defeituosa, 'Inspecionar eletrodos das velas de ignição').

% Ações Secundárias (Se primária não resolver)
acao_corretiva_secundaria(bateria_fraca, 'Substituir bateria se teste indicar falha').
acao_corretiva_secundaria(alternador_defeituoso, 'Substituir alternador se teste confirmar defeito').
acao_corretiva_secundaria(nivel_oleo_baixo, 'Investigar possível vazamento no motor').
acao_corretiva_secundaria(superaquecimento, 'Verificar funcionamento da bomba d\'água e termostato').
acao_corretiva_secundaria(vela_ignicao_defeituosa, 'Substituir conjunto de velas de ignição').

% Ações Preventivas
acao_preventiva(bateria_fraca, 'Limpar terminais da bateria e aplicar vaselina').
acao_preventiva(alternador_defeituoso, 'Verificar tensão da correia do alternador').
acao_preventiva(nivel_oleo_baixo, 'Estabelecer rotina de verificação quinzenal do óleo').
acao_preventiva(superaquecimento, 'Limpar radiador e verificar líquido a cada 6 meses').

% Custo Estimado das Ações (em unidades monetárias)
custo_acao(bateria_fraca, verificacao, 0).
custo_acao(bateria_fraca, substituicao, 200).
custo_acao(alternador_defeituoso, verificacao, 50).
custo_acao(alternador_defeituoso, substituicao, 400).
custo_acao(vela_ignicao_defeituosa, verificacao, 30).
custo_acao(vela_ignicao_defeituosa, substituicao, 120).

% Tempo Estimado (em minutos)
tempo_acao(bateria_fraca, verificacao, 15).
tempo_acao(bateria_fraca, substituicao, 30).
tempo_acao(alternador_defeituoso, verificacao, 45).
tempo_acao(alternador_defeituoso, substituicao, 120).
tempo_acao(vela_ignicao_defeituosa, verificacao, 20).
tempo_acao(vela_ignicao_defeituosa, substituicao, 60).

% Sistema de Recomendação Inteligente
recomendar_acao_completa(Problema) :-
    .
format('=== RECOMENDAÇÃO PARA: ~w ===~n', [Problema]),

% Ação Primária
(acao_corretiva_primaria(Problema, AcaoPrimaria) ->
format('1. AÇÃO PRIMÁRIA: ~w~n', [AcaoPrimaria]) ;
write('1. Nenhuma ação primária definida.~n')),

% Ação Secundária
(acao_corretiva_secundaria(Problema, AcaoSecundaria) ->
format('2. SE NECESSÁRIO: ~w~n', [AcaoSecundaria]) ;
write('2. Nenhuma ação secundária definida.~n')),

% Ação Preventiva
(acao_preventiva(Problema, AcaoPreventiva) ->
format('3. PREVENÇÃO: ~w~n', [AcaoPreventiva]) ;
write('3. Nenhuma ação preventiva definida.~n')),

% Informações de Custo e Tempo
mostrar_custos_tempo(Problema),
nl.

% Mostra custos e tempos estimados
mostrar_custos_tempo(Problema) :-
    .
write('ESTIMATIVAS:~n'),
(custo_acao(Problema, verificacao, CustoVerif) ->
format('- Custo verificação: ~w unidades~n', [CustoVerif]) ; true),
(custo_acao(Problema, substituicao, CustoSubst) ->
format('- Custo substituição: ~w unidades~n', [CustoSubst]) ; true),
(tempo_acao(Problema, verificacao, TempoVerif) ->
format('- Tempo verificação: ~w minutos~n', [TempoVerif]) ; true),
(tempo_acao(Problema, substituicao, TempoSubst) ->
format('- Tempo substituição: ~w minutos~n', [TempoSubst]) ; true).

% Lógica de Decisão para Múltiplos Problemas
plano_manutencao_completo :-
    .
write('=== PLANO DE MANUTENÇÃO COMPLETO ===~n~n'),
diagnosticos_alternativos(ListaDiagnosticos),
executar_plano_por_prioridade(ListaDiagnosticos, 1).

% Executa o plano ordenado por prioridade
executar_plano_por_prioridade([], _).
executar_plano_por_prioridade([diagnostico_info(Problema, Prob, Comp, Pont)|Resto], Num) :-
    .
format('~w. PRIORIDADE ~w (Pontuação: ~w)~n', [Num, Prob, Pont]),
recomendar_acao_completa(Problema),
Num1 is Num + 1,
executar_plano_por_prioridade(Resto, Num1).

% CONSULTAS ESPECÍFICAS ÚTEIS ATUALIZADAS
% Consultar problema específico
consultar_problema(Problema) :-
    .
causa(Sintoma, Problema, Probabilidade),
format('Sintoma: ~w pode causar ~w (Probabilidade: ~w)~n',
[Sintoma, Problema, Probabilidade]),
fail.
consultar_problema(_).

% Consultar componente específico
consultar_componente(Componente) :-
    .
componente_relacionado(Problema, Componente),
diagnostico(Problema, Probabilidade, Componente),
format('Componente ~w pode ter problema: ~w (Probabilidade: ~w)~n',
[Componente, Problema, Probabilidade]),
fail.
consultar_componente(_).

% Listar todos os sintomas possíveis
listar_sintomas :-
    .
sintoma(S),
write('- '), write(S), nl,
fail.
listar_sintomas.

% Simular cenário de teste
simular_cenario_conflito :-
    .
write('=== SIMULAÇÃO DE CENÁRIOS DE CONFLITO ===~n~n'),
analisar_conflito(1),
nl,
analisar_conflito(2),
nl,
analisar_conflito(3).

% EXERCÍCIO 5: EXPLICABILIDADE (JUSTIFICATIVAS)
% Sistema de Explicabilidade - Rastear Evidências
evidencia_sensor(Problema, Sensor, Valor, Limite, Tipo) :-
    .
sensor_critico(Sensor, Valor, Problema),
limite_critico(Sensor, Tipo, Limite).

evidencia_sintoma(Problema, Sintoma, Probabilidade) :-
    .
causa(Sintoma, Problema, Probabilidade),
sintoma_presente(Sintoma).

% Explicar Como Chegou à Conclusão
explicar_diagnostico(Problema) :-
    .
format('=== EXPLICAÇÃO DO DIAGNÓSTICO: ~w ===~n~n', [Problema]),

% Verificar se existe evidência de sensores
(evidencia_sensor(Problema, Sensor, Valor, Limite, Tipo) ->
explicar_evidencia_sensor(Problema, Sensor, Valor, Limite, Tipo) ;
write('SENSORES: Nenhuma evidência direta de sensores.~n~n')),

% Verificar evidências de sintomas
(evidencia_sintoma(Problema, _, _) ->
explicar_evidencias_sintomas(Problema) ;
write('SINTOMAS: Nenhum sintoma relacionado detectado.~n~n')),

% Calcular e explicar pontuação
(diagnostico_prioritario(Problema, Probabilidade, Componente, Pontuacao) ->
explicar_pontuacao(Problema, Probabilidade, Componente, Pontuacao) ;
write('PONTUAÇÃO: Não foi possível calcular pontuação.~n~n')),

% Explicar por que este diagnóstico foi escolhido
explicar_escolha(Problema).

% Explicar evidência de sensor específico
explicar_evidencia_sensor(Problema, Sensor, Valor, Limite, Tipo) :-
    .
format('EVIDÊNCIA DE SENSOR:~n'),
format('- Sensor ~w registrou valor: ~w~n', [Sensor, Valor]),
format('- Limite ~w configurado: ~w~n', [Tipo, Limite]),
(Tipo = minimo ->
(Valor < Limite ->
format('- CONCLUSÃO: Valor ~w está ABAIXO do limite mínimo ~w~n', [Valor, Limite]) ;
format('- CONCLUSÃO: Valor ~w está ACIMA do limite mínimo ~w~n', [Valor, Limite])) ;
(Valor > Limite ->
format('- CONCLUSÃO: Valor ~w está ACIMA do limite máximo ~w~n', [Valor, Limite]) ;
format('- CONCLUSÃO: Valor ~w está ABAIXO do limite máximo ~w~n', [Valor, Limite]))),
format('- DIAGNÓSTICO INFERIDO: ~w~n~n', [Problema]).

% Explicar todas as evidências de sintomas
explicar_evidencias_sintomas(Problema) :-
    .
format('EVIDÊNCIAS DE SINTOMAS:~n'),
findall(info_sintoma(Sintoma, Prob), evidencia_sintoma(Problema, Sintoma, Prob), ListaSintomas),
explicar_cada_sintoma(ListaSintomas),
nl.

explicar_cada_sintoma([]).
explicar_cada_sintoma([info_sintoma(Sintoma, Prob)|Resto]) :-
    .
format('- Sintoma presente: ~w~n', [Sintoma]),
format('  * Probabilidade de causar ~w: ~w~n', [Problema, Prob]),
peso_probabilidade(Prob, Peso),
format('  * Peso atribuído: ~w~n', [Peso]),
explicar_cada_sintoma(Resto).

% Explicar cálculo da pontuação
explicar_pontuacao(Problema, Probabilidade, Componente, Pontuacao) :-
    .
format('CÁLCULO DA PONTUAÇÃO:~n'),
peso_probabilidade(Probabilidade, Peso),
contar_sintomas_relacionados(Problema, ContadorSintomas),
format('- Probabilidade geral: ~w (peso: ~w)~n', [Probabilidade, Peso]),
format('- Número de sintomas relacionados: ~w~n', [ContadorSintomas]),
format('- Pontuação calculada: ~w × ~w = ~w~n', [Peso, ContadorSintomas, Pontuacao]),
format('- Componente afetado: ~w~n~n', [Componente]).

% Explicar por que este diagnóstico foi escolhido
explicar_escolha(Problema) :-
    .
format('JUSTIFICATIVA DA ESCOLHA:~n'),
diagnosticos_alternativos(ListaDiagnosticos),
[diagnostico_info(MelhorProblema, _, _, MaiorPont)|_] = ListaDiagnosticos,
(Problema = MelhorProblema ->
format('- ~w foi escolhido por ter a MAIOR pontuação (~w)~n', [Problema, MaiorPont]) ;
format('- ~w NÃO foi o diagnóstico principal (pontuação menor)~n', [Problema])),
comparar_com_alternatives(Problema, ListaDiagnosticos).

% Comparar com diagnósticos alternativos
comparar_com_alternatives(_, []).
comparar_com_alternatives(Problema, [diagnostico_info(OutroProblema, _, _, OutraPont)|Resto]) :-
    .
(Problema \= OutroProblema ->
format('- Comparado com ~w (pontuação: ~w)~n', [OutroProblema, OutraPont]) ;
true),
comparar_com_alternatives(Problema, Resto).

% Sistema "Por Que NÃO" - Explicar Causas Descartadas
explicar_por_que_nao(ProblemaDescartado) :-
    .
format('=== POR QUE NÃO: ~w ===~n~n', [ProblemaDescartado]),

% Verificar se há sintomas que NÃO suportam este diagnóstico
explicar_sintomas_ausentes(ProblemaDescartado),

% Verificar se sensores contradizem o diagnóstico
explicar_sensores_contraditorios(ProblemaDescartado),

% Comparar pontuação com diagnósticos aceitos
explicar_pontuacao_insuficiente(ProblemaDescartado),

% Verificar condições não atendidas
explicar_condicoes_nao_atendidas(ProblemaDescartado).

% Explicar sintomas ausentes que seriam esperados
explicar_sintomas_ausentes(Problema) :-
    .
format('SINTOMAS ESPERADOS MAS AUSENTES:~n'),
findall(Sintoma, (causa(Sintoma, Problema, alta), \+ sintoma_presente(Sintoma)), SintomasAusentes),
(SintomasAusentes = [] ->
write('- Todos os sintomas esperados estão presentes ou não há sintomas de alta probabilidade.~n') ;
mostrar_sintomas_ausentes(SintomasAusentes, Problema)),
nl.

mostrar_sintomas_ausentes([], _).
mostrar_sintomas_ausentes([Sintoma|Resto], Problema) :-
    .
format('- ~w NÃO foi detectado (esperado para ~w com alta probabilidade)~n', [Sintoma, Problema]),
mostrar_sintomas_ausentes(Resto, Problema).

% Explicar sensores que contradizem o diagnóstico
explicar_sensores_contraditorios(Problema) :-
    .
format('SENSORES CONTRADITÓRIOS:~n'),
encontrar_contradicoes_sensor(Problema, Contradicoes),
(Contradicoes = [] ->
write('- Nenhum sensor contradiz este diagnóstico.~n') ;
mostrar_contradicoes(Contradicoes)),
nl.

% Encontrar contradições entre sensores e diagnóstico esperado
encontrar_contradicoes_sensor(bateria_fraca, Contradicoes) :-
    .
leitura_sensor(tensao_bateria, Tensao),
(Tensao >= 12.0 ->
Contradicoes = [contradicao('Tensão da bateria está normal', Tensao, '>=12.0V')] ;
Contradicoes = []).

encontrar_contradicoes_sensor(superaquecimento, Contradicoes) :-
    .
leitura_sensor(temperatura_motor, Temp),
(Temp =< 100 ->
Contradicoes = [contradicao('Temperatura do motor está normal', Temp, '<=100°C')] ;
Contradicoes = []).

encontrar_contradicoes_sensor(nivel_oleo_baixo, Contradicoes) :-
    .
leitura_sensor(nivel_oleo, Nivel),
(Nivel >= 20 ->
Contradicoes = [contradicao('Nível de óleo está adequado', Nivel, '>=20%')] ;
Contradicoes = []).

encontrar_contradicoes_sensor(_, []).

mostrar_contradicoes([]).
mostrar_contradicoes([contradicao(Desc, Valor, Limite)|Resto]) :-
    .
format('- ~w: ~w ~w~n', [Desc, Valor, Limite]),
mostrar_contradicoes(Resto).

% Explicar pontuação insuficiente
explicar_pontuacao_insuficiente(ProblemaDescartado) :-
    .
format('PONTUAÇÃO COMPARATIVA:~n'),
(diagnostico_prioritario(ProblemaDescartado, Prob, _, Pont) ->
(melhor_diagnostico(MelhorProb, _, _, MaiorPont) ->
format('- ~w teve pontuação: ~w~n', [ProblemaDescartado, Pont]),
format('- Melhor diagnóstico teve pontuação: ~w~n', [MaiorPont]),
Diferenca is MaiorPont - Pont,
format('- Diferença: ~w pontos~n', [Diferenca]),
(Diferenca > 0 ->
write('- CONCLUSÃO: Pontuação insuficiente para ser o diagnóstico principal.~n') ;
write('- CONCLUSÃO: Pontuação equivalente, outros fatores determinaram a escolha.~n')) ;
format('- ~w teve pontuação: ~w, mas não há comparativo disponível~n', [ProblemaDescartado, Pont])) ;
write('- Não foi possível calcular pontuação para este problema.~n')),
nl.

% Explicar condições específicas não atendidas
explicar_condicoes_nao_atendidas(Problema) :-
    .
format('CONDIÇÕES ESPECÍFICAS:~n'),
verificar_condicoes_especificas(Problema, Condicoes),
(Condicoes = [] ->
write('- Todas as condições básicas foram atendidas.~n') ;
mostrar_condicoes_nao_atendidas(Condicoes)),
nl.

% Verificar condições específicas para cada tipo de problema
verificar_condicoes_especificas(bateria_fraca, Condicoes) :-
    .
findall(Cond, (
(sintoma_presente(falha_ignicao) ->
Cond = 'Falha de ignição presente - suporta diagnóstico' ;
Cond = 'Falha de ignição ausente - enfraquece diagnóstico')
), Condicoes).

verificar_condicoes_especificas(_, []).

mostrar_condicoes_nao_atendidas([]).
mostrar_condicoes_nao_atendidas([Condicao|Resto]) :-
    .
format('- ~w~n', [Condicao]),
mostrar_condicoes_nao_atendidas(Resto).

% Análise Comparativa Completa
analise_explicabilidade_completa :-
    .
write('=== ANÁLISE DE EXPLICABILIDADE COMPLETA ===~n~n'),

% Explicar o melhor diagnóstico
melhor_diagnostico(MelhorProblema, _, _, _),
format('DIAGNÓSTICO PRINCIPAL: ~w~n', [MelhorProblema]),
explicar_diagnostico(MelhorProblema),

% Explicar por que outros foram descartados
write('~n=== DIAGNÓSTICOS ALTERNATIVOS DESCARTADOS ===~n'),
diagnosticos_alternativos([_|Resto]), % Remove o primeiro (melhor)
explicar_descartados(Resto).

explicar_descartados([]).
explicar_descartados([diagnostico_info(Problema, _, _, _)|Resto]) :-
    .
explicar_por_que_nao(Problema),
explicar_descartados(Resto).

% Consulta Interativa de Explicabilidade
perguntar_explicacao :-
    .
write('Qual diagnóstico você gostaria que eu explique? '),
read(Problema),
(diagnostico(Problema, _, _) ->
explicar_diagnostico(Problema) ;
(write('Problema não encontrado. Por que este diagnóstico foi descartado?~n'),
explicar_por_que_nao(Problema))).

% Justificativa em Linguagem Natural
justificar_em_linguagem_natural(Problema) :-
    .
format('=== JUSTIFICATIVA SIMPLIFICADA: ~w ===~n~n', [Problema]),

% Construir explicação em linguagem natural
contar_sintomas_relacionados(Problema, NumSintomas),
diagnostico_prioritario(Problema, Probabilidade, Componente, Pontuacao),

format('Eu diagnostiquei ~w porque:~n', [Problema]),
format('1. Encontrei ~w sintoma(s) que indicam este problema~n', [NumSintomas]),
format('2. A probabilidade geral é ~w~n', [Probabilidade]),
format('3. O componente ~w está relacionado~n', [Componente]),
format('4. A pontuação total (~w) foi a mais alta~n~n', [Pontuacao]),

% Adicionar detalhes específicos
adicionar_detalhes_naturais(Problema).

% Adicionar detalhes específicos em linguagem natural
adicionar_detalhes_naturais(bateria_fraca) :-
    .
leitura_sensor(tensao_bateria, Tensao),
format('Especificamente, a tensão da bateria (~wV) está abaixo do limite normal (12.0V).~n', [Tensao]),
(sintoma_presente(falha_ignicao) ->
write('Além disso, há falha de ignição, que é consistente com bateria fraca.~n') ;
write('Embora não haja falha de ignição reportada, os sensores indicam problema elétrico.~n')).

adicionar_detalhes_naturais(superaquecimento) :-
    .
leitura_sensor(temperatura_motor, Temp),
format('A temperatura do motor (~w°C) excede o limite seguro (100°C).~n', [Temp]),
(sintoma_presente(barulho_incomum_motor) ->
write('O barulho incomum pode indicar danos por superaquecimento.~n') ;
write('Felizmente, ainda não há barulhos anômalos reportados.~n')).

adicionar_detalhes_naturais(nivel_oleo_baixo) :-
    .
leitura_sensor(nivel_oleo, Nivel),
format('O nível de óleo (~w%%) está abaixo do mínimo recomendado (20%%).~n', [Nivel]),
write('Isso pode causar danos graves ao motor se não for corrigido rapidamente.~n').

adicionar_detalhes_naturais(_) :-
    .
write('Os sensores e sintomas convergem para este diagnóstico.~n').

% Sistema de Confiança na Explicação
calcular_confianca_explicacao(Problema, Confianca) :-
    .
% Fatores que aumentam confiança
contar_sintomas_relacionados(Problema, NumSintomas),
(evidencia_sensor(Problema, _, _, _, _) -> EvidenciaSensor = 1 ; EvidenciaSensor = 0),
diagnostico_prioritario(Problema, Probabilidade, _, _),
peso_probabilidade(Probabilidade, Peso),

% Calcular confiança (0-100%)
ConfiancaSintomas is NumSintomas * 20,
ConfiancaSensor is EvidenciaSensor * 30,
ConfiancaProbabilidade is Peso * 15,

ConfiancaTotal is ConfiancaSintomas + ConfiancaSensor + ConfiancaProbabilidade,
Confianca is min(100, ConfiancaTotal).

% Relatório de Confiança
relatorio_confianca(Problema) :-
    .
format('=== RELATÓRIO DE CONFIANÇA: ~w ===~n~n', [Problema]),
calcular_confianca_explicacao(Problema, Confianca),
format('Nível de confiança: ~w%~n~n', [Confianca]),

% Explicar componentes da confiança
contar_sintomas_relacionados(Problema, NumSintomas),
format('Fatores que AUMENTAM a confiança:~n'),
format('- Sintomas relacionados: ~w (~w pontos)~n', [NumSintomas, NumSintomas * 20]),

(evidencia_sensor(Problema, Sensor, _, _, _) ->
format('- Evidência de sensor ~w: 30 pontos~n', [Sensor]) ;
write('- Nenhuma evidência direta de sensor: 0 pontos~n')),

diagnostico_prioritario(Problema, Probabilidade, _, _),
peso_probabilidade(Probabilidade, Peso),
PontosProbabilidade is Peso * 15,
format('- Probabilidade ~w: ~w pontos~n~n', [Probabilidade, PontosProbabilidade]),

% Classificar confiança
classificar_confianca(Confianca).

classificar_confianca(Confianca) :-
    .
(Confianca >= 80 ->
write('INTERPRETAÇÃO: Diagnóstico MUITO CONFIÁVEL - Recomenda-se ação imediata.~n') ;
(Confianca >= 60 ->
write('INTERPRETAÇÃO: Diagnóstico CONFIÁVEL - Investigação adicional recomendada.~n') ;
(Confianca >= 40 ->
write('INTERPRETAÇÃO: Diagnóstico MODERADO - Verificações adicionais necessárias.~n') ;
write('INTERPRETAÇÃO: Diagnóstico INCERTO - Mais evidências necessárias.~n')))).

% Rastreamento de Decisões (Audit Trail)
 :-
    dynamic(decisao_tomada/4)..

registrar_decisao(Passo, Acao, Razao, Resultado) :-
    .
assertz(decisao_tomada(Passo, Acao, Razao, Resultado)).

inicializar_auditoria :-
    .
retractall(decisao_tomada(_, _, _, _)),
registrar_decisao(1, 'Coleta de dados', 'Leitura de sensores e sintomas', 'Dados coletados').

mostrar_trilha_auditoria :-
    .
write('=== TRILHA DE AUDITORIA DO DIAGNÓSTICO ===~n~n'),
decisao_tomada(Passo, Acao, Razao, Resultado),
format('~w. ~w~n   Razão: ~w~n   Resultado: ~w~n~n', [Passo, Acao, Razao, Resultado]),
fail.
mostrar_trilha_auditoria.

% Explicação Passo a Passo
diagnostico_passo_a_passo(Problema) :-
    .
format('=== DIAGNÓSTICO PASSO A PASSO: ~w ===~n~n', [Problema]),
inicializar_auditoria,

% Passo 1: Coleta de dados
write('PASSO 1: Coleta de Dados~n'),
write('- Lendo sensores do veículo...~n'),
write('- Coletando sintomas reportados...~n'),
registrar_decisao(2, 'Análise de sensores', 'Verificar limites críticos', 'Sensores analisados'),
nl,

% Passo 2: Análise inicial
write('PASSO 2: Análise Inicial~n'),
(sensor_critico(Sensor, Valor, ProblemaDetectado) ->
(format('- Sensor ~w detectou anomalia: ~w~n', [Sensor, Valor]),
registrar_decisao(3, 'Problema identificado por sensor', Sensor, ProblemaDetectado)) ;
(write('- Nenhuma anomalia crítica em sensores~n'),
registrar_decisao(3, 'Análise de sintomas', 'Sensores normais', 'Foco em sintomas'))),
nl,

% Passo 3: Correlação com sintomas
write('PASSO 3: Correlação com Sintomas~n'),
findall(S, (causa(S, Problema, _), sintoma_presente(S)), SintomasRelacionados),
length(SintomasRelacionados, NumSintomas),
format('- Encontrados ~w sintoma(s) relacionados: ~w~n', [NumSintomas, SintomasRelacionados]),
registrar_decisao(4, 'Correlação sintomas', SintomasRelacionados, NumSintomas),
nl,

% Passo 4: Cálculo de pontuação
write('PASSO 4: Cálculo de Probabilidade~n'),
diagnostico_prioritario(Problema, Probabilidade, Componente, Pontuacao),
format('- Probabilidade: ~w, Componente: ~w, Pontuação: ~w~n', [Probabilidade, Componente, Pontuacao]),
registrar_decisao(5, 'Cálculo final', 'Algoritmo de pontuação', Pontuacao),
nl,

% Passo 5: Decisão final
write('PASSO 5: Decisão Final~n'),
melhor_diagnostico(MelhorProblema, _, _, MaiorPont),
(Problema = MelhorProblema ->
format('- ~w foi SELECIONADO como diagnóstico principal (pontuação: ~w)~n', [Problema, MaiorPont]) ;
format('- ~w foi DESCARTADO (pontuação insuficiente)~n', [Problema])),
registrar_decisao(6, 'Decisão final', 'Comparação de pontuações', MelhorProblema),
nl,

write('=== TRILHA COMPLETA ===~n'),
mostrar_trilha_auditoria.

% EXEMPLOS DE USO EXPANDIDOS:
% CONSULTAS BÁSICAS:
?- executar_diagnostico.
?- consultar_problema(bateria_fraca).
?- consultar_componente(bateria).
?- sensor_critico(S, V, P).
?- diagnostico(P, alta, C).

% CONFLITOS E PRIORIZAÇÃO:
?- melhor_diagnostico(Problema, Prob, Comp, Pontuacao).
?- analisar_conflito(1).
?- diagnosticos_alternativos(Lista).
?- simular_cenario_conflito.

% AÇÕES CORRETIVAS:
?- recomendar_acao_completa(bateria_fraca).
?- plano_manutencao_completo.
?- custo_acao(bateria_fraca, substituicao, Custo).
?- tempo_acao(alternador_defeituoso, verificacao, Tempo).

% EXPLICABILIDADE:
?- explicar_diagnostico(bateria_fraca).
?- explicar_por_que_nao(superaquecimento).
?- analise_explicabilidade_completa.
?- justificar_em_linguagem_natural(bateria_fraca).
?- relatorio_confianca(bateria_fraca).
?- diagnostico_passo_a_passo(bateria_fraca).
?- perguntar_explicacao.