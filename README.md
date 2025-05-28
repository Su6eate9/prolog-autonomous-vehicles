# prolog-autonomous-vehicles
Imagine que você trabalha em uma equipe de desenvolvimento de software para veículos autônomos. Um dos módulos desse sistema precisa diagnosticar problemas mecânicos e elétricos no veículo com base em leituras de sensores e estados internos.


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



## Caso de Teste 3 — Motor Engasgado em Altas Rotações

### Regras Ativadas:

* O sintoma de **barulho em altas rotações** pode estar relacionado a **nível de óleo baixo** ou **bomba d'água defeituosa**.
* A luz de **Check Engine piscando em alta rotação** tem relação direta com **sensor de oxigênio defeituoso** ou **falha no sistema de injeção**.
* O sistema também infere que o **sensor de oxigênio está fora da faixa**, reforçando essa suspeita.

### Justificativa do Diagnóstico:

O sistema considera um cenário de **conflito entre múltiplas causas possíveis**, mas prioriza:

* **Sensor de oxigênio defeituoso**, pois é o mais diretamente ligado ao sintoma da luz de **Check Engine piscando em altas rotações**, especialmente porque o problema ocorre só em altas rotações (característico de falha no sensor de O2).
* O sistema de injeção também é considerado, mas fica em segundo plano, pois uma falha na injeção normalmente geraria sintomas em todas as faixas de rotação.

### Ações Corretivas:

1. Fazer diagnóstico no **sensor de oxigênio** (via scanner automotivo).
2. Verificar o sistema de injeção eletrônica.
3. Avaliar a mistura ar-combustível e funcionamento em diferentes regimes de rotação.
4. Se necessário, substituir o sensor defeituoso.


## Caso de Teste 4 — Ruídos no Motor ao Acelerar

### Regras Ativadas:

* O **barulho metálico ao acelerar** está associado a possíveis problemas como **nível de óleo baixo**, **tensor da correia frouxo**, **bomba d'água defeituosa** ou **rolamento defeituoso**.
* A **perda de potência** não possui uma regra clara no código atual, o que limita o diagnóstico automático.
* O **sensor de vibração** indicando valores anormais reforça a suspeita de problema mecânico grave.

### Justificativa do Diagnóstico:

O sistema tenta associar os sintomas a problemas conhecidos, mas encontra limitações na base de conhecimento atual, que não possui regras para defeitos como:

* **Biela danificada**
* **Junta de cabeçote**
* **Problemas na transmissão**

Com os recursos atuais, o sistema retorna uma possível suspeita de **nível de óleo baixo** como causa do barulho, mas **não consegue justificar diretamente a perda de potência**.

Idealmente, o diagnóstico deveria sugerir:

* Se o ruído vem da parte do motor, a causa pode ser **biela danificada ou junta de cabeçote defeituosa**.
* Se o ruído vem da transmissão, pode ser um problema no **sistema de tração ou na caixa de câmbio**.

### Ações Corretivas:

1. Realizar inspeção física detalhada no motor.
2. Verificar nível de óleo e procurar por indícios de desgaste interno (limalhas metálicas no óleo).
3. Avaliar componentes como **biela, pistões, junta de cabeçote** e também transmissão.
4. Se confirmado problema interno do motor, realizar desmontagem para manutenção pesada.
5. Testar o sistema de transmissão se houver indício de que o ruído vem dessa região.


## Conclusão

Este conjunto de exercícios visou familiarizar os alunos com os princípios de **base de conhecimento**, **regras lógicas** e **inferência de diagnóstico**, aplicando-os no contexto de um veículo inteligente. No projeto desenvolvido em equipe, as seguintes etapas foram contempladas de forma prática:

1. **Definição de sintomas e causas:**  
   Foram definidos diversos sintomas possíveis de falhas em veículos, como falha de ignição, luzes no painel, barulho no motor, entre outros. Para cada sintoma, foram mapeadas múltiplas causas prováveis com diferentes níveis de probabilidade (alta, média e baixa), refletindo diferentes situações reais de falha automotiva.

2. **Uso de leituras de sensores para inferir estados de falha:**  
   O sistema foi projetado para ler valores simulados de sensores como temperatura do motor, tensão da bateria, nível de óleo e pressão do óleo. Esses valores são comparados com limites críticos para identificar condições anormais e inferir falhas como superaquecimento, bateria fraca, rotação instável, entre outros.

3. **Tratamento de prioridades e conflitos:**  
   Implementamos uma lógica de decisão que calcula a pontuação de cada diagnóstico com base na probabilidade da causa e na quantidade de sintomas relacionados. Quando há múltiplas causas possíveis, o sistema escolhe a mais provável utilizando regras de corte (`!`) e priorização, além de permitir simulações de conflitos entre sintomas.

4. **Geração de ações corretivas:**  
   O sistema sugere ações corretivas específicas para cada falha detectada, divididas em ações primárias, secundárias e preventivas. Também foram incluídos dados de custo e tempo estimado de manutenção, tornando a recomendação mais realista e útil em cenários aplicáveis.

5. **Explicabilidade do sistema:**  
   Foram criadas funcionalidades que explicam, em linguagem técnica e natural, como o sistema chegou a determinado diagnóstico. Além disso, há explicações sobre por que certas hipóteses foram descartadas, bem como um relatório de confiança e uma trilha de auditoria passo a passo, promovendo transparência e rastreabilidade.


Ao final, espera-se que os alunos desenvolvam (por conta própria) um **protótipo em Prolog**, organizando as regras e fatos de forma que cubra os cenários de teste e seja capaz de explicar o raciocínio por trás de cada diagnóstico. Este trabalho atendeu completamente a esse objetivo.
