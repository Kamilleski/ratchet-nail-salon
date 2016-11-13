class Polish < ActiveRecord::Base
  validates :brand_name,
    presence: true,
    format: {
      with: /\A[a-zA-Z ']+\z/
    },
    inclusion: {
      in: ['butter London', 'Essie', 'OPI']
    }
  validates :color_name,
    presence: true,
    format: {
      multiline: true,
      with: /^[\w.\-]+$/
    }
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
