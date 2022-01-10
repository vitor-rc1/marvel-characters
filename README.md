# Desafio - Desenvolvedor iOS

O objetivo é implementar um app :iphone: onde podemos ver a lista de personagens da Marvel. O app deve mostrar uma lista e ser possível navegar para os detalhes de cada personagem :space_invader:. Além disso, tanto na lista quanto na tela de detalhes, deve ser possível favoritar :star: o personagem. Os personagens favoritados devem ser persistidos no device para que possam ser acessados offline e serem mostrados em uma aba própria.

## API

Para desenvolver o app :iphone: você vai precisar usar o endpoint de `"Characters"` da API Marvel. 
Mais informações: https://developer.marvel.com/docs.

## Interface

- [ ] A interface do app :iphone: é dividida em **3 partes** e deve ser desenvolvida conforme os pontos abaixo.

### Home - Characters

- [ ] Listagem dos personagens ordenados por ordem :abc: alfabética.
- [ ] Botão para favoritar :star: personagem nas células.
- [ ] Pull-to-refresh :arrows_counterclockwise: para atualizar a lista.
- [ ] Altenar modo de exibição entre **grid** ou **list**.
- [ ] Paginação na lista:
    - Carregar **20 personagens** :space_invader: por vez, baixando a próxima página ao chegar no fim da lista.
- [ ] Interface de :warning: lista vazia, erro ou sem internet.

### Detalhes do personagem

- [ ] Botão de favorito :star:.
- [ ] Foto :foggy: em tamanho maior.
- [ ] Nome do personagem na barra de navegação.
- [ ] Descrição do personagem :space_invader: se houver, caso contrário exibir uma mensagem  *"sem descrição."* .
- [ ] Lista horizontal de Comics *(se houver)*.
- [ ] Lista horizontal de Series *(se houver)*.
- [ ] Interface de lista vazia, :no_mobile_phones: erro ou sem internet.

### Favoritos

- [ ] Listagem dos personagens favoritados pelo usuário *(exibindo apenas o nome e imagem do personagem)*.
- [ ] Não há limite de personagens a serem favoritados :metal:.
- [ ] Favoritos devem ser persistidos (apenas nome e imagem do personagem) localmente para serem acessados offline.

## Requisitos Essenciais

- [ ] Usar Swift 5.
- [ ] Interface no Storyboard usando Auto Layout.
- [ ] Tratamento para :no_mobile_phones: falha de conexão.
- [ ] O teste não pode apresentar crash :boom:.
- [ ] Testes unitários.
- [ ] Widget com os 3 primeiros personagens com ação de abrir o app no detalhe do personagem.

### Wireframe

Abaixo :eyes: temos os wireframes das telas do app.

| ![Page1](public/Characters.png)  | ![Page2](public/Favorites.png) | ![Page3](public/Detail.png) |
|:---:|:---:|:---:|
| Lista de Personagens | Favoritos | Detalhes do Personagem |

## Bônus

- [ ] App universal, desenvolva uma interface que se adapte a telas maiores.
- [ ] Testes de interface :+1:.
- [ ] Integração com fastlane para cobertura :bar_chart: de testes.

## Observações

- [ ] Você pode :point_up: utilizar bibliotecas de terceiros e gerenciadores de dependências (CocoaPods, Carthage, etc) como preferir.
- [ ] Fique a vontade :wave: para trabalhar com os dados usando UserDefault, CoreData, Realm ou cache de serviço.
- [ ] Foque o desenvolvimento nos requisitos essenciais. O bônus vai diferenciar você dos outros candidatos, mas **os requisitos essenciais são mais importantes**.
