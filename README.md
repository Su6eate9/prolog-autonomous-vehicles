# prolog-autonomous-vehicles
Imagine que você trabalha em uma equipe de desenvolvimento de software para veículos autônomos. Um dos módulos desse sistema precisa diagnosticar problemas mecânicos e elétricos no veículo com base em leituras de sensores e estados internos.

Perfeito, Nickolas! Aqui estão as **respostas completas do item 4 — Respostas Esperadas**, conforme solicitado no PDF, baseadas no código `simple.pl` e nos casos de teste do arquivo `TESTS.md`. Está tudo detalhado, direto e sem código, como foi pedido.

---

## Caso de Teste 1 — Partida Inconsistente

### Regras Ativadas:

* A regra de sensor detectou que a **tensão da bateria (11,8V) está abaixo do limite mínimo de 12V**, classificando como **bateria fraca**.
* A regra de diagnóstico por sintomas identificou que a **luz da bateria acesa** e a **falha de ignição** estão ambas associadas à **bateria fraca** (alta e média probabilidade, respectivamente), além de também apontar possibilidade de **alternador defeituoso**.

### Justificativa do Diagnóstico:

O sistema prioriza **bateria fraca**, pois:

* A tensão registrada está abaixo do limite crítico.
* A soma dos sintomas gera uma pontuação maior para bateria fraca em relação ao alternador.

A presença da luz da bateria piscando levanta uma segunda suspeita de **alternador defeituoso**, que só se confirma se, após testar e recarregar a bateria, o problema continuar ocorrendo.

### Ações Corretivas:

1. Testar a tensão da bateria com multímetro.
2. Se estiver com problema, substituir a bateria.
3. Se o problema persistir, realizar diagnóstico no alternador.
4. Fazer manutenção preventiva nos terminais da bateria (limpeza e proteção).

## Caso de Teste 2 — Superaquecimento no Motor

### Regras Ativadas:

* O sistema detecta que a **temperatura do motor (105°C) está acima do limite de 100°C**, indicando **superaquecimento**.
* Detecta também que o **nível de óleo (15) está abaixo do mínimo (20)**, apontando **nível de óleo baixo**.
* A luz de **Check Engine acesa** sugere problemas adicionais como **sensor de oxigênio defeituoso** ou **falha no sistema de injeção**.

### Justificativa do Diagnóstico:

O sistema identifica **múltiplos problemas críticos**:

* O **superaquecimento** tem relação direta com a temperatura alta.
* O **nível de óleo baixo** pode ser uma das causas do superaquecimento, além de indicar falta de manutenção ou vazamento.
* A luz de **Check Engine** pode estar acendendo como efeito colateral de problemas no motor ou no sistema de emissão.

### Ações Corretivas:

1. Desligar o veículo imediatamente para evitar danos maiores.
2. Verificar e completar o nível de óleo.
3. Inspecionar possíveis vazamentos ou falha no sistema de lubrificação.
4. Verificar também o sistema de arrefecimento (líquido, radiador, bomba d'água).
5. Realizar diagnóstico no motor e nos sensores associados.
