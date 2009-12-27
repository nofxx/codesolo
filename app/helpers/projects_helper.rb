module ProjectsHelper

  def skill_select(obj)
    out = obj.label :skill
    out << obj.select(:skill, (1..5).to_a.inject(ActiveSupport::OrderedHash.new) do |h, i|
                        h.merge({ skill_text(i) => i })
                      end)
  end

  def skill_text(i)
    t("skills.#{i}")
  end



end


# { "Beginner" => 1,
#                          "Amateur" => 2,
#                          "Pro"    => 3,
#                          "Master" => 4,
#                          "Jedi"   => 5}
