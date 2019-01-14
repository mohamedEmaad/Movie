
import Foundation
struct SinglePersonDetails : Codable {
	let birthday : String?
	let known_for_department : String?
	let deathday : String?
	let id : Int?
	let name : String?
	let also_known_as : [String]?
	let gender : Int?
	let biography : String?
	let popularity : Double?
	let place_of_birth : String?
	let profile_path : String?
	let adult : Bool?
	let imdb_id : String?
	let homepage : String?

	enum CodingKeys: String, CodingKey {

		case birthday = "birthday"
		case known_for_department = "known_for_department"
		case deathday = "deathday"
		case id = "id"
		case name = "name"
		case also_known_as = "also_known_as"
		case gender = "gender"
		case biography = "biography"
		case popularity = "popularity"
		case place_of_birth = "place_of_birth"
		case profile_path = "profile_path"
		case adult = "adult"
		case imdb_id = "imdb_id"
		case homepage = "homepage"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		birthday = try values.decodeIfPresent(String.self, forKey: .birthday)
		known_for_department = try values.decodeIfPresent(String.self, forKey: .known_for_department)
		deathday = try values.decodeIfPresent(String.self, forKey: .deathday)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		also_known_as = try values.decodeIfPresent([String].self, forKey: .also_known_as)
		gender = try values.decodeIfPresent(Int.self, forKey: .gender)
		biography = try values.decodeIfPresent(String.self, forKey: .biography)
		popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
		place_of_birth = try values.decodeIfPresent(String.self, forKey: .place_of_birth)
		profile_path = try values.decodeIfPresent(String.self, forKey: .profile_path)
		adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
		imdb_id = try values.decodeIfPresent(String.self, forKey: .imdb_id)
		homepage = try values.decodeIfPresent(String.self, forKey: .homepage)
	}

}
