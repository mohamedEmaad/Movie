
import Foundation
struct Known_for : Codable {
	let original_name : String?
	let id : Int?
	let media_type : String?
	let name : String?
	let vote_count : Int?
	let vote_average : Double?
	let poster_path : String?
	let first_air_date : String?
	let popularity : Double?
	let genre_ids : [Int]?
	let original_language : String?
	let backdrop_path : String?
	let overview : String?
	let origin_country : [String]?

	enum CodingKeys: String, CodingKey {

		case original_name = "original_name"
		case id = "id"
		case media_type = "media_type"
		case name = "name"
		case vote_count = "vote_count"
		case vote_average = "vote_average"
		case poster_path = "poster_path"
		case first_air_date = "first_air_date"
		case popularity = "popularity"
		case genre_ids = "genre_ids"
		case original_language = "original_language"
		case backdrop_path = "backdrop_path"
		case overview = "overview"
		case origin_country = "origin_country"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		original_name = try values.decodeIfPresent(String.self, forKey: .original_name)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		media_type = try values.decodeIfPresent(String.self, forKey: .media_type)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		vote_count = try values.decodeIfPresent(Int.self, forKey: .vote_count)
		vote_average = try values.decodeIfPresent(Double.self, forKey: .vote_average)
		poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
		first_air_date = try values.decodeIfPresent(String.self, forKey: .first_air_date)
		popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
		genre_ids = try values.decodeIfPresent([Int].self, forKey: .genre_ids)
		original_language = try values.decodeIfPresent(String.self, forKey: .original_language)
		backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
		overview = try values.decodeIfPresent(String.self, forKey: .overview)
		origin_country = try values.decodeIfPresent([String].self, forKey: .origin_country)
	}

}
