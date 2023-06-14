import Foundation
import Combine

class Download_NetworkUtility {
    let localResponseCode = 0
    
    enum DownloadNetworkUtilityError: LocalizedError {
        case badServer
        case unknownError
        
        var errorDescription: String? {
            switch self {
            case .badServer :
                return "Bad Server Response, We will get you back soon"
            case .unknownError:
                return "Unknow Error Invoked"
            }
        }
    }
    
    static func downloadPublisher(url: URL) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) -> Data in
                guard
                    let response = output.response as? HTTPURLResponse else {
                    throw DownloadNetworkUtilityError.badServer
                }
                print(response.statusCode)
                return output.data
            }
            .eraseToAnyPublisher()
    }
    
    static func sinkCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}
