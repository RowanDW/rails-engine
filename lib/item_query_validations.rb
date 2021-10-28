module ItemQueryValidations
  def valid_name_search?
    if params[:name] && params[:min_price].nil? && params[:max_price].nil?
      return params[:name] != ""
    end
    false
  end

  def valid_price_search?
    if params[:name]
      return false
    elsif !params[:min_price].nil? && !params[:max_price].nil?
      valid_max_price_search? && valid_min_price_search?
    else
      valid_max_price_search? || valid_min_price_search?
    end
  end

  def valid_min_price_search?
    params[:min_price].to_i > 0 && params[:min_price] != ''
  end

  def valid_max_price_search?
    if  params[:max_price].to_i > 0 && params[:max_price] != ''
      if valid_min_price_search? && (params[:max_price].to_i < params[:min_price].to_i)
        return false
      end
       return true
    end
    false
  end
end
