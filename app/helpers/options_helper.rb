# -*- coding: utf-8 -*-
module OptionsHelper

  def language_select
    select "user", "locale", [
      ['Português', 'pt'],
      ['English', 'en-US']]
  end
end
