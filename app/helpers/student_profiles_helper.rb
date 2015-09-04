module StudentProfilesHelper

  def high_schools
    {
      "Adel-DeSoto-Minburn High School" => {logo: "adm.png"},
      "Ankeny Centennial High School" => {logo: "ankeny-centennial.png"},
      "Ankeny High School" => {logo: "ankeny-hawks.png"},
      "Carlisle High School" => {logo: "carlisle.png"},
      "Dallas Center-Grimes High School" => {logo: "dallas-center.png"},
      "Des Moines Christian High School" => {logo: "dsm-christian.png"},
      "Dowling Catholic High School" => {logo: "dowling.png"},
      "East High School" => {logo: "east.png"},
      "Forreston High School" => {logo: "forreston-logo.jpg"},
      "Hoover High School" => {logo: "hoover.png"},
      "Indianola High School" => {logo: "indianola.png"},
      "Johnston High School" => {logo: "johnston.png"},
      "Lincoln High School" => {logo: "lincoln.png"},
      "Linn-Mar High School" => {logo: "linn-mar.jpg"},
      "Martensdale-St. Mary's High School" => {logo: "martensdale-logo.jpg"},
      "North High School" => {logo: "north.png"},
      "North Polk High School" => {logo: "north-polk.png"},
      "Norwalk Senior High School" => {logo: "norwalk.png"},
      "Other" => {logo: "other.png"}
      "Roosevelt High School" => {logo: "roosevelt.png"},
      "Saydel High School High School" => {logo: "saydel.png"},
      "Sioux City West High School" => {logo: "sioux-city-west.png"},
      "South Sioux City High School" => {logo: "south-sioux-city.jpg"},
      "Southeast Polk High School" => {logo: "southeast-polk.png"},
      "Urbandale High School" => {logo: "urbandale.png"},
      "Valley High School" => {logo: "valley.png"},
      "Van Meter High School" => {logo: "van-meter.png"},
      "Waukee High School" => {logo: "waukee.png"},
      "Woodward-Granger High School" => {logo: "woodward.png"},
      "Xavier High School" => {logo: "xavier.jpg"},
    }
  end


  def student_interests
    {
      "Baseball" => {logo: "baseball.png"},
      "Basketball" => {logo: "bball.png"},
      "Bowling" => {logo: "bowling.png"},
      "Cheerleading" => {logo: "cheer.png"},
      "Choir" => {logo: "choir.png"},
      "Cross Country" => {logo: "running.png"},
      "Drama" => {logo: "drama.png"},
      "Football" => {logo: "football.png"},
      "Golf" => {logo: "golf.png"},
      "Marching Band" => {logo: "marchingband.png"},
      "Robotics" => {logo: "robotics.png"},
      "Soccer" => {logo: "soccer.png"},
      "Speech/Debate" => {logo: "debate.png"}
      "Swimming" => {logo: "swimming.png"},
      "Tennis" => {logo: "tennis.png"},
      "Track" => {logo: "track.png"},
      "Writing" => {logo: "writing.png"},
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
