protocol CharactersViewModelProtocol {
    func fetchCharacters(page: Int, callback: @escaping ([MarvelCharacter]) -> Void)
}

protocol CharactersViewModelDelegate: AnyObject {
    func didLoadCharacters()
    func showError(message: String)
}
