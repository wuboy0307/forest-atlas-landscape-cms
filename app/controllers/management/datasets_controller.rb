class Management::DatasetsController < ManagementController

  before_action :ensure_management_user, only: :destroy
  before_action :set_site, only: [:index, :new, :create]
  before_action :set_dataset, only: [:edit, :destroy]
  before_action :set_datasets, only: [:index]

  # Validate if user can modify the dataset
  before_action :authenticate_user_for_site!

  def index
    gon.datasets = @datasets.map do |dataset|
      {
        'title' => {'value' => dataset.name, 'searchable' => true, 'sortable' => true},
        'contexts' => {'value' => ContextDataset.where(dataset_id: dataset.id).map{|ds| ds.context.name}.join(', '), 'searchable' => true, 'sortable' => false},
        'connector' => {'value' => dataset.provider, 'searchable' => true, 'sortable' => true},
        'tags' => {'value' => dataset.tags, 'searchable' => true, 'sortable' => false},
        'status' => {'value' => dataset.metadata['status'], 'searchable' => true, 'sortable' => true},
        # TODO: once both actions work properly, restore buttons
        # 'edit' => {'value' => edit_management_site_dataset_dataset_step_path(@site.slug, dataset.id, 'title'), 'method' => 'get'},
        # 'delete' => {'value' => management_site_dataset_path(@site.slug, dataset.id), 'method' => 'delete'}
      }
    end
  end

  # TODO: What should happen when we destroy a dataset??
  def destroy
    #@dataset.destroy
    redirect_to controller: 'management/datasets', action: 'index', site_slug: @site.slug, notice: 'Dataset was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_site
    @site = Site.find_by({slug: params[:site_slug]})

    if (@site.routes.any?)
      # We just want a valid URL for the site
      @url = @site.routes.first.host
    end
  end

  # Gets a dataset from the API and sets it to the member variable
  def set_dataset
    # TODO
    #@dataset = DatasetService.get_dataset
  end

  # TODO: Use cache for this
  # Gets the datasets from the API and sets them to the member variable
  def set_datasets
    @datasets = current_user.get_datasets 'all'

    @metadata_array = []
    @metadata_array = Dataset.get_metadata_list(@datasets.map{|ds| ds.id}) if @datasets

    # TODO: Find a better way to do this
    @datasets.each_with_index do |ds, i|
      ds.metadata = @metadata_array['data'][i]['attributes']
    end
  end
end
