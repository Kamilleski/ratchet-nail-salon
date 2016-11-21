class Polish < ActiveRecord::Base
  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
    :sorted_by,
    :search_query,
    :with_color_group,
    :with_polish_type,
    :with_brand_name,
    :with_created_at_gte
    ]
  )
  scope :with_color_group, lambda { |color_groups|
    where(color_group: [*color_groups])
  }

  scope :with_brand_name, lambda { |brand_names|
    where(brand_name: [*brand_names])
  }

  scope :with_polish_type, lambda { |polish_types|
    where(polish_type: [*polish_types])
  }

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      # Simple sort on the created_at column.
      # Make sure to include the table name to avoid ambiguous column names.
      # Joining on other tables is quite common in Filterrific, and almost
      # every ActiveRecord table has a 'created_at' column.
      order("polishes.created_at #{ direction }")
    when /^color_name_/
      # Simple sort on the name colums
      order("LOWER(polishes.color_name) #{ direction }, LOWER(polishes.color_name) #{ direction }")
    when /^polish_type/
      # Simple sort on the name colums
      order("LOWER(polishes.polish_type) #{ direction }, LOWER(polishes.polish_type) #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :search_query, lambda { |query|
    return nil  if query.blank?

    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)

    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conds = 2
    where(
      terms.map { |term|
        "(LOWER(polishes.color_name) LIKE ? OR LOWER(polishes.brand_name) LIKE ?)"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  def self.options_for_sorted_by
    [
      ['Color Name (a-z)', 'color_name_asc'],
      ['Creation Date (newest first)', 'created_at_desc'],
      ['Creation Date (oldest first)', 'created_at_asc'],
      ['Polish Type (a-z)', 'polish_type_asc']
    ]
  end

  def height_finder(polish)
    case polish.brand_name
    when 'butter London'
      return "65x65"
    when 'Essie'
      return "65x140"
    when 'OPI'
    end
  end

  validates :brand_name,
    presence: true,
    format: {
      with: /\A[a-zA-Z ']+\z/
    },
    inclusion: {
      in: ['butter London', 'Essie', 'OPI']
    }
  validates :color_name,
    presence: true
  validates :brand_number,
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      only_integer: true
    }
  validates :upc,
    presence: true,
    format: {
      :multiline => true,
      with: /^[0-9]{1,45}$/
    }
  validates :color_group,
    presence: true,
    format: {
      with: /\A[a-zA-Z ']+\z/
    },
    inclusion: {
      in: ['Pinks', 'Neutrals', 'Grays', 'Corals', 'Reds', 'Plums', 'Deeps', 'Blues', 'Greens']
    }
  validates :polish_type,
    presence: true,
    format: {
      with: /\A[a-zA-Z ']+\z/
    },
    inclusion: {
      in: ['Metallics', 'Mattes', 'Effects', 'None']
    }
  validates :hex_color,
    presence: true
  validates :description,
    presence: true
  validates :image_url,
    presence: true
end
