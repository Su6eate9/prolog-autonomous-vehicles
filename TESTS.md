## Caso de Teste 1: Partida Inconsistente

#

## Sintomas Coletados:

- Veículo às vezes não dá partida → **sintoma_presente(falha_ignicao)**

- Luz de bateria piscando no painel → **sintoma_presente(luz_bateria_acesa)**

- Tensão da bateria registrada em 11,8V → **leitura_sensor(tensao_bateria, 11.8)**

#

## Regras Disparadas:

1. **Análise de Sensor Crítico:**
    
    

```
prolog

    sensor_critico(tensao_bateria, 11.8, bateria_fraca) :-
        leitura_sensor(tensao_bateria, 11.8),
        limite_critico(tensao_bateria, minimo, 12.0),
        11.8 < 12.0,
        problema_sensor_baixo(tensao_bateria, bateria_fraca).
    
    
```

    
2. **Diagnóstico por Sintomas:**
    
    

```
prolog

    % Falha de ignição → bateria fraca (probabilidade alta)
    causa(falha_ignicao, bateria_fraca, alta).
    
    % Luz bateria acesa → alternador defeituoso (probabilidade alta)
    causa(luz_bateria_acesa, alternador_defeituoso, alta).
    causa(luz_bateria_acesa, bateria_fraca, media).
    
    
```

    
3. **Cálculo de Pontuação:**
    
- **bateria_fraca**: 2 sintomas relacionados × peso 3 (alta) = **6 pontos**
    
- **alternador_defeituoso**: 1 sintoma × peso 3 (alta) = **3 pontos**

#

## Diagnóstico Final:

**PROBLEMA PRINCIPAL: bateria_fraca (6 pontos)**

#

## Justificativa do Sistema:

```

=== EXPLICAÇÃO DO DIAGNÓSTICO: bateria_fraca ===

EVIDÊNCIA DE SENSOR:

- Sensor tensao_bateria registrou valor: 11.8

- Limite minimo configurado: 12.0

- CONCLUSÃO: Valor 11.8 está ABAIXO do limite mínimo 12.0

- DIAGNÓSTICO INFERIDO: bateria_fraca

EVIDÊNCIAS DE SINTOMAS:

- Sintoma presente: falha_ignicao
  * Probabilidade de causar bateria_fraca: alta
  * Peso atribuído: 3

- Sintoma presente: luz_bateria_acesa
  * Probabilidade de causar bateria_fraca: media
  * Peso atribuído: 2

CÁLCULO DA PONTUAÇÃO:

- Probabilidade geral: alta (peso: 3)

- Número de sintomas relacionados: 2

- Pontuação calculada: 3 × 2 = 6

- Componente afetado: bateria

```

#

## Ações Corretivas Recomendadas:

1. **AÇÃO PRIMÁRIA:** Testar tensão da bateria com multímetro
2. **SE NECESSÁRIO:** Substituir bateria se teste indicar falha
3. **PREVENÇÃO:** Limpar terminais da bateria e aplicar vaselina
4. **ESTIMATIVAS:** Custo verificação: 0 unidades, Substituição: 200 unidades

## Caso de Teste 2: Superaquecimento no Motor

#

## Sintomas Coletados:

- Temperatura do motor alcançando 105°C → **leitura_sensor(temperatura_motor, 105)**

- Luz de "Check Engine" acesa → **sintoma_presente(check_engine_acesa)**

- Nível de óleo próximo ao mínimo → **leitura_sensor(nivel_oleo, 15)** (abaixo de 20)

#

## Regras Disparadas:

1. **Análise de Sensores Críticos:**
    
    

```
prolog

    % Temperatura alta
    sensor_critico(temperatura_motor, 105, superaquecimento) :-
        leitura_sensor(temperatura_motor, 105),
        limite_critico(temperatura_motor, maximo, 100),
        105 > 100,
        problema_sensor_alto(temperatura_motor, superaquecimento).
    
    % Nível de óleo baixo
    sensor_critico(nivel_oleo, 15, nivel_oleo_baixo) :-
        leitura_sensor(nivel_oleo, 15),
        limite_critico(nivel_oleo, minimo, 20),
        15 < 20,
        problema_sensor_baixo(nivel_oleo, nivel_oleo_baixo).
    
    
```

    
2. **Diagnóstico por Sintomas:**
    
    

```
prolog

    causa(check_engine_acesa, sensor_oxigenio_defeituoso, alta).
    causa(check_engine_acesa, sistema_injecao_falho, alta).
    
    
```

    

#

## Diagnósticos Identificados:

1. **superaquecimento** 
- Evidência direta do sensor
2. **nivel_oleo_baixo** 
- Evidência direta do sensor
3. **sensor_oxigenio_defeituoso** 
- Por sintoma check_engine

#

## Diagnóstico Final Priorizado:

**MÚLTIPLOS PROBLEMAS CRÍTICOS DETECTADOS**

#

## Justificativa do Sistema:

```

DIAGNÓSTICO COMBINADO:

- Superaquecimento confirmado (105°C > 100°C)

- Nível de óleo crítico (15% < 20%)

- Check Engine indica problema adicional no sistema

CORRELAÇÃO:
O nível baixo de óleo pode estar CAUSANDO o superaquecimento,
criando um ciclo de problemas que requer atenção imediata.

```

#

## Ações Corretivas Urgentes:

1. **IMEDIATO:** Parar o veículo e desligar o motor
2. **VERIFICAR:** Nível de óleo e completar se necessário
3. **INVESTIGAR:** Possível vazamento no motor
4. **VERIFICAR:** Nível do líquido de arrefecimento e funcionamento do radiador

## Caso de Teste 3: Motor Engasgado em Altas Rotações

#

## Sintomas Coletados:

- Barulhos intermitentes acima de 3000 RPM → **sintoma_presente(barulho_incomum_motor)**

- Luz de "Check Engine" piscando → **sintoma_presente(check_engine_acesa)**

- Sensor de oxigênio fora da faixa → **sintoma inferido**

#

## Regras Disparadas:

1. **Análise de Sintomas:**
    
    

```
prolog

    % Barulho incomum
    causa(barulho_incomum_motor, nivel_oleo_baixo, alta).
    causa(barulho_incomum_motor, bomba_agua_defeituosa, media).
    
    % Check Engine
    causa(check_engine_acesa, sensor_oxigenio_defeituoso, alta).
    causa(check_engine_acesa, sistema_injecao_falho, alta).
    
    
```

    
2. **Diagnósticos Competindo:**
    
- **sensor_oxigenio_defeituoso**: 1 sintoma × peso 3 = 3 pontos
    
- **sistema_injecao_falho**: 1 sintoma × peso 3 = 3 pontos
    
- **nivel_oleo_baixo**: 1 sintoma × peso 3 = 3 pontos

#

## Resolução de Conflito:

O sistema detecta **CENÁRIO DE CONFLITO** e aplica análise adicional:

```
prolog

cenario_conflito(3, [check_engine_acesa, perda_potencia], 'Conflito sistema injeção').

```

#

## Diagnóstico Final:

**sensor_oxigenio_defeituoso** (priorizado por especificidade do sintoma)

#

## Justificativa:

```

ANÁLISE DE CONFLITO: Conflito sistema injeção

RESOLUÇÃO:

- Check Engine intermitente em alta rotação é indicativo específico

- Sensor de oxigênio defeituoso afeta principalmente altas rotações

- Sistema de injeção seria mais consistente em todas as rotações

```

#

## Ações Corretivas:

1. **DIAGNÓSTICO:** Executar diagnóstico do sistema de injeção eletrônica
2. **VERIFICAR:** Sensor de oxigênio com scanner automotivo
3. **TESTAR:** Mistura ar-combustível em diferentes rotações

## Caso de Teste 4: Ruídos no Motor ao Acelerar

#

## Sintomas Coletados:

- Ruído metálico ao acelerar → **sintoma_presente(barulho_incomum_motor)**

- Rotação sobe mas perda de potência → **sintoma_presente(perda_potencia)**

- Check Engine não acende → **ausência de sintoma**

- Sensor de vibração anormal → **inferência adicional**

#

## Regras Disparadas:

1. **Análise de Sintomas:**
    
    

```
prolog

    causa(barulho_incomum_motor, nivel_oleo_baixo, alta).
    causa(barulho_incomum_motor, bomba_agua_defeituosa, media).
    causa(barulho_incomum_motor, tensor_correia_frouxo, media).
    causa(barulho_incomum_motor, rolamento_defeituoso, baixa).
    
    
```

    
2. **Análise de Perda de Potência:**
    
    

```
prolog

    causa(perda_potencia, sistema_injecao_falho, ?).
    % (Sintoma definido mas sem causas específicas no código atual)
    
    
```

    

#

## Limitação do Sistema Atual:

O código fornecido **não inclui regras específicas** para:

- Problemas de transmissão

- Junta de cabeçote

- Bielas danificadas

#

## Diagnóstico com Recursos Disponíveis:

**nivel_oleo_baixo** (baseado em barulho_incomum_motor)

#

## Recomendação de Expansão:

Para este caso, seria necessário adicionar ao sistema:

```
prolog

% Regras adicionais necessárias
causa(barulho_incomum_motor, biela_danificada, alta).
causa(barulho_incomum_motor, junta_cabecote_defeituosa, media).
causa(perda_potencia, problema_transmissao, alta).
causa(perda_potencia, biela_danificada, media).

% Componentes adicionais
componente_relacionado(biela_danificada, motor_interno).
componente_relacionado(problema_transmissao, sistema_transmissao).

```

#

## Diagnóstico Melhorado (com expansões):

**PROBLEMA CRÍTICO: biela_danificada**

- Justificativa: Ruído metálico + perda de potência são sinais clássicos

- Ação: Inspeção interna do motor necessária

## Análise Geral dos Casos de Teste

#

## Pontos Fortes do Sistema:

1. **Integração sensor-sintoma** funciona bem (Casos 1 e 2)
2. **Sistema de pontuação** resolve conflitos efetivamente
3. **Explicabilidade** fornece justificativas claras
4. **Ações corretivas** são práticas e hierarquizadas

#

## Limitações Identificadas:

1. **Base de conhecimento limitada** para problemas mecânicos complexos (Caso 4)
2. **Falta de regras** para correlações específicas (transmissão, motor interno)
3. **Sintomas não mapeados** completamente (perda_potencia tem poucas causas)

#

## Recomendações de Melhoria:

1. **Expandir base de conhecimento** com mais causas mecânicas
2. **Adicionar sensores** de vibração, pressão, etc.
3. **Implementar aprendizado** baseado em histórico de casos
4. **Melhorar correlações** entre múltiplos sintomas simultâneos

#

## Conclusão:

O sistema demonstra excelente capacidade para diagnósticos elétricos e básicos, com forte sistema de explicabilidade. Para casos mecânicos complexos, necessita expansão da base de conhecimento.

#

## ✅ **Pontos Fortes:**

- **Integração sensores-sintomas**: O sistema correlaciona bem leituras numéricas com regras lógicas

- **Sistema de pontuação**: Resolve conflitos entre múltiplos diagnósticos de forma eficaz

- **Explicabilidade robusta**: Fornece justificativas detalhadas para cada decisão

- **Ações corretivas estruturadas**: Organizadas em primárias, secundárias e preventivas

#

## ⚠️ **Limitações Identificadas:**

- **Base limitada para problemas mecânicos complexos** (Caso 4 
- bielas, transmissão)

- **Alguns sintomas não completamente mapeados** (perda_potencia tem poucas causas)

- **Necessita expansão** para cobrir mais cenários automotivos reais

## **Como o Sistema Processa Cada Caso:**

1. **Caso 1** (Partida Inconsistente): Sistema identifica corretamente `bateria_fraca` através de sensor + sintomas
2. **Caso 2** (Superaquecimento): Detecta múltiplos problemas críticos correlacionados
3. **Caso 3** (Motor Engasgado): Resolve conflito priorizando `sensor_oxigenio_defeituoso`
4. **Caso 4** (Ruídos Metálicos): Limitado pela base de conhecimento atual