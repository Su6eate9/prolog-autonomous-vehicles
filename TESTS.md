## Caso de Teste 1: Partida Inconsistente

### Sintomas Coletados:

- Veículo às vezes não dá partida → **sintoma_presente(falha_ignicao)**
- Luz de bateria piscando no painel → **sintoma_presente(luz_bateria_acesa)**
- Tensão da bateria registrada em 11,8V → **leitura_sensor(tensao_bateria, 11.8)**

### Regras Disparadas:

1. **Análise de Sensor Crítico:**
    
    ```prolog
    sensor_critico(tensao_bateria, 11.8, bateria_fraca) :-
        leitura_sensor(tensao_bateria, 11.8),
        limite_critico(tensao_bateria, minimo, 12.0),
        11.8 < 12.0,
        problema_sensor_baixo(tensao_bateria, bateria_fraca).
    
    ```
    
2. **Diagnóstico por Sintomas:**
    
    ```prolog
    % Falha de ignição → bateria fraca (probabilidade alta)
    causa(falha_ignicao, bateria_fraca, alta).
    
    % Luz bateria acesa → alternador defeituoso (probabilidade alta)
    causa(luz_bateria_acesa, alternador_defeituoso, alta).
    causa(luz_bateria_acesa, bateria_fraca, media).
    
    ```
    
3. **Cálculo de Pontuação:**
    - **bateria_fraca**: 2 sintomas relacionados × peso 3 (alta) = **6 pontos**
    - **alternador_defeituoso**: 1 sintoma × peso 3 (alta) = **3 pontos**

### Diagnóstico Final:

**PROBLEMA PRINCIPAL: bateria_fraca (6 pontos)**

### Justificativa do Sistema:

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

### Ações Corretivas Recomendadas:

1. **AÇÃO PRIMÁRIA:** Testar tensão da bateria com multímetro
2. **SE NECESSÁRIO:** Substituir bateria se teste indicar falha
3. **PREVENÇÃO:** Limpar terminais da bateria e aplicar vaselina
4. **ESTIMATIVAS:** Custo verificação: 0 unidades, Substituição: 200 unidades