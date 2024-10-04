# 🚀 Engenheiro de Software Móvel - Desafio Tractian

## 📌 Sumário
1. Contexto
2. Desafio
3. Estrutura da Árvore
4. Recursos Implementados
5. Dados Técnicos
6. Desenvolvimento
7. Demonstração
8. Melhorias Futuras
9. Conclusão

## 📚 Contexto
Na indústria moderna, os ativos desempenham um papel crucial, abrangendo desde equipamentos de fabricação até sistemas de geração de energia. A gestão eficiente desses ativos é fundamental para manter a produtividade e reduzir custos operacionais. Uma visualização clara da hierarquia de ativos, através de uma estrutura de árvore, facilita significativamente este processo de gestão.

## 🎯 Desafio
O objetivo principal deste projeto é desenvolver um aplicativo móvel que apresente uma visualização em árvore dos ativos empresariais. Esta estrutura hierárquica é composta por três elementos principais: componentes, ativos e locais.

## 🌳 Estrutura da Árvore
A hierarquia de ativos é representada da seguinte forma:

- Raiz
  - Local A
    - Ativo 1
      - Componente A1
      - Componente A2
    - Ativo 2
      - Componente B1
      - Componente B2
  - Localização B
    - Localização C
      - Ativo 3
        - Componente C1
        - Componente C2
      - Componente D1
  - Componente X

## 🛠️ Recursos Implementados

### 1. Página Inicial
- Interface intuitiva para navegação entre empresas
- Acesso rápido aos ativos de cada empresa
- Tratamento de UI quando estiver sem internet ou com erro no carregamento

### 2. Página de Ativos
- [OK] Visualização da Árvore: Representação dinâmica e interativa da hierarquia de ativos
- [OK] Tratamento de UI quando estiver sem internet ou com erro no carregamento
- [PENDENTE] Sistema de Filtros Avançado:

## 📊 Dados Técnicos

### Estrutura de Dados dos Locais

{
  "id": "65674204664c41001e91ecb4",
  "name": "ÁREA DE PRODUÇÃO - MATÉRIA-PRIMA",
  "parentId": null
}

### Estrutura de Dados dos Ativos
{
  "id": "656734821f4664001f296973",
  "name": "Ventilador - Externo",
  "parentId": null,
  "sensorId": "MTC052",
  "sensorType": "energy",
  "status": "operating",
  "gatewayId": "QHI640",
  "locationId": null
}

## 💻 Desenvolvimento

### Tecnologias Utilizadas
- Framework: Flutter
- Gerenciamento de Estado: ChangeNotifier + SetState
- Injeção de dependência: Provider
- Consumo de API (DIO): Implementação eficiente para integração de dados em tempo real
    - Inversão de dependência, fazendo o serviço ser desacoplado
- UI/UX: Design responsivo e intuitivo, priorizando a experiência do usuário

### Boas Práticas Implementadas
- Arquitetura limpa para facilitar manutenção e escalabilidade
- Testes unitários e de integração para garantir robustez
  - Serviço de API
  - Serviço de checar Conectividade
- Otimização de performance para carregamento rápido de grandes conjuntos de dados
  - Faltou a implementaçao de um Isolate para uma melhor performance com houverem muitos dados

## 🎥 Demonstração
[https://youtu.be/vrGu-ejrLLw]

O vídeo acima demonstra:
1. Abertura do aplicativo
2. Navegação entre diferentes empresas
3. Visualização da árvore de ativos

## 🔮 Melhorias Futuras
1. Implementação de cache local para melhorar o desempenho offline
2. Adição de funcionalidades de edição da árvore de ativos
3. Integração com sistemas de notificação para alertas em tempo real
4. Expansão das capacidades de análise de dados e geração de relatórios
5. Desenvolvimento dos filtros com Chips e o buscador
6. Otimização de performance para carregamento rápido de grandes conjuntos de dados (Isolate)

## 🏁 Conclusão
O aplicativo foi desenvolvido com uma abordagem baseada na arquitetura limpa, que assegura uma estrutura organizada e escalável, facilitando a manutenção e a evolução do sistema. A separação , domínio, serviços e UI permite uma inversão de controle eficaz, garantindo que a lógica de negócios permaneça independente da camada de apresentação.

---

Desenvolvido com 🫣 por Victor Ruan Diniz Pereira
