module EntriesHelper

  def entry_category_select selected = nil
    grouped_options_for_select({
      'Upgrade' => Vehicle.mod_categories,
      'Ownership' => [:bought, :sold],
      'Update' => [:journey, :journal]
    }, selected)
  end
end

