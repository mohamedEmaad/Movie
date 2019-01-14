
import Foundation
struct Profiles : Codable {
	let iso_639_1 : String?
	let width : Int?
	let height : Int?
	let vote_count : Int?
	let vote_average : Double?
	let file_path : String?
	let aspect_ratio : Double?

	enum CodingKeys: String, CodingKey {

		case iso_639_1 = "iso_639_1"
		case width = "width"
		case height = "height"
		case vote_count = "vote_count"
		case vote_average = "vote_average"
		case file_path = "file_path"
		case aspect_ratio = "aspect_ratio"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		iso_639_1 = try values.decodeIfPresent(String.self, forKey: .iso_639_1)
		width = try values.decodeIfPresent(Int.self, forKey: .width)
		height = try values.decodeIfPresent(Int.self, forKey: .height)
		vote_count = try values.decodeIfPresent(Int.self, forKey: .vote_count)
		vote_average = try values.decodeIfPresent(Double.self, forKey: .vote_average)
		file_path = try values.decodeIfPresent(String.self, forKey: .file_path)
		aspect_ratio = try values.decodeIfPresent(Double.self, forKey: .aspect_ratio)
	}

}
