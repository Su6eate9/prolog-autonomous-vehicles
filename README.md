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