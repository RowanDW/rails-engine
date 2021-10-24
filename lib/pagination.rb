module Pagination
  def limit
    lim = params.fetch(:per_page, 20).to_i
    if lim > 0
      lim
    else
      20
    end
  end

  def per_page
    offset = params.fetch(:page, 1).to_i
    if offset > 0
      (offset - 1) * limit
    else
      0
    end
  end
end
