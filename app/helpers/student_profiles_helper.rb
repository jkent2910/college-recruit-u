module StudentProfilesHelper

  def high_schools
    {
      "Valley High School" => {logo: "valley.png"},
      "Ankeny Centennial High School" => {logo: "ankeny-centennial.png"},
      "Dowling Catholic High School" => {logo: "dowling.png"},
      "Waukee High School" => {logo: "waukee.png"},
      "Johnston High School" => {logo: "johnston.png"},
      "Des Moines Christian High School" => {logo: "dsm-christian.png"},
      "Roosevelt High School" => {logo: "roosevelt.png"},
      "Lincoln High School" => {logo: "lincoln.png"},
      "East High School" => {logo: "east.png"},
      "Hoover High School" => {logo: "hoover.png"},
      "North High School" => {logo: "north.png"},
      "Saydel High School High School" => {logo: "saydel.png"},
      "Urbandale High School" => {logo: "urbandale.png"},
      "Southeast Polk High School" => {logo: "southeast-polk.png"},
      "Ankeny High School" => {logo: "ankeny-hawks.png"},
      "Dallas Center-Grimes High School" => {logo: "dallas-center.png"},
      "North Polk High School" => {logo: "north-polk.png"},
      "Adel-DeSoto-Minburn High School" => {logo: "adm.png"},
      "Van Meter High School" => {logo: "van-meter.png"},
      "Woodward-Granger High School" => {logo: "woodward.png"},
      "Carlisle High School" => {logo: "carlisle.png"},
      "Indianola High School" => {logo: "indianola.png"},
      "Norwalk Senior High School" => {logo: "norwalk.png"},
      "South Sioux City High School" => {logo: "south-sioux-city.jpg"},
      "Sioux City West High School" => {logo: "sioux-city-west.png"},
      "Xavier High School" => {logo: "xavier.jpg"},
      "Linn-Mar High School" => {logo: "linn-mar.jpg"},
      "Other" => {logo: "other.png"}
    }
  end


  def student_interests
    {
      "Marching Band" => {logo: "marchingband.png"},
      "Choir" => {logo: "choir.png"},
      "Basketball" => {logo: "bball.png"},
      "Baseball" => {logo: "baseball.png"},
      "Tennis" => {logo: "tennis.png"},
      "Football" => {logo: "football.png"},
      "Cheerleading" => {logo: "cheer.png"},
      "Golf" => {logo: "golf.png"},
      "Drama" => {logo: "drama.png"},
      "Cross Country" => {logo: "running.png"},
      "Track" => {logo: "track.png"},
      "Soccer" => {logo: "soccer.png"},
      "Bowling" => {logo: "bowling.png"},
      "Robotics" => {logo: "robotics.png"},
      "Writing" => {logo: "writing.png"},
      "Swimming" => {logo: "swimming.png"},
      "Speech/Debate" => {logo: "debate.png"}
    }
  end

  def student_majors
    {
      "Agriculture" => {logo: "agriculture.png"},
      "Architecture" => {logo: "architecture.png"},
      "Art" => {logo: "art.png"},
      "Biology" => {logo: "biology.png"},
      "Business" => {logo: "business.png"},
      "Communications" => {logo: "communications.png"},
      "Criminal Justice" => {logo: "criminaljustice.png"},
      "Education" => {logo: "education.png"}, 
      "English" => {logo: "english.png"},
      "Engineering" => {logo: "engineering.png"},
      "Health Sciences" => {logo: "healthscience.png"},
      "Languages & Literature" => {logo: "literature.png"},
      "Mathematics" => {logo: "mathematics.png"},
      "Other" => {logo: "other.png"},
      "Philosophy & Religion" => {logo: "philosophy.png"}, 
      "Pre-Law" => {logo: "prelaw.png"},
      "Pre-Med" => {logo: "premed.png"},
      "Psychology" => {logo: "psychology.png"},
      "Social Services" => {logo: "socialservices.png"},
      "Visual & Performing Arts" => {logo: "performingarts.png"}
    }
  end


  def pronoun(gender)
    case gender
    when /female/i
      "her"
    else
      "his"
    end
  end
end
