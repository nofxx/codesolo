module ProjectsHelper

  def skill_select(obj)
    out = obj.label :skill
  #  out << obj.select(:skill, 1..5.to_a.inject({}) { |h, i| h.merge({ i => skill_name(i)})})
  end

  def skill_name(i)
    t("skills.#{i}")
  end
end


# { "Beginner" => 1,
#                          "Amateur" => 2,
#                          "Pro"    => 3,
#                          "Master" => 4,
#                          "Jedi"   => 5}
