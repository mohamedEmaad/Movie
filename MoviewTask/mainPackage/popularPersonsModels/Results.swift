
import Foundation
struct Results : Codable {
	let popularity : Double?
	let id : Int?
	let profile_path : String?
	let name : String?
	let known_for : [Known_for]?
	let adult : Bool?

	enum CodingKeys: String, CodingKey {

		case popularity = "popularity"
		case id = "id"
		case profile_path = "profile_path"
		case name = "name"
		case known_for = "known_for"
		case adult = "adult"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		profile_path = try values.decodeIfPresent(String.self, forKey: .profile_path)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		known_for = try values.decodeIfPresent([Known_for].self, forKey: .known_for)
		adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
	}

}
