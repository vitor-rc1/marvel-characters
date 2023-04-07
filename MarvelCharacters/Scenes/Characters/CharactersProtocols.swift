protocol CharactersViewModelProtocol {
    func getCharacter(index: Int) -> MarvelCharacter
    func getCharacters()
    func getCharactersCount() -> Int
    func getNextCharactersPage()
}

protocol CharactersViewModelDelegate: AnyObject {
    func didLoadCharacters()
    func showError(message: String)
}
