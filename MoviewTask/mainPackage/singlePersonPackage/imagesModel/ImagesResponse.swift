
import Foundation
struct ImagesResponse : Codable {
	let profiles : [Profiles]?
	let id : Int?

	enum CodingKeys: String, CodingKey {

		case profiles = "profiles"
		case id = "id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		profiles = try values.decodeIfPresent([Profiles].self, forKey: .profiles)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
	}

}
