def create_pages_templates
  home = PageTemplate.create!(
    {
      name: 'Homepage',
      description: 'Homepage description',
      uri: '',
      content_type: ContentType::HOMEPAGE,
      site_templates: [@fa_template, @la_template]
    }
  )

  PageTemplate.create!(
    {
      name: 'Map',
      description: 'Explore the map',
      content: {settings: File.read(Dir.pwd + '/lib/tasks/map_config.json')},
      uri: 'map',
      parent: home,
      content_type: ContentType::MAP,
      site_templates: [@fa_template, @la_template]
    }
  )

  PageTemplate.create!(
    {
      name: 'Data',
      description: 'Download the data',
      content: {url: 'http://cmr-data.forest-atlas.org/'},
      uri: 'data',
      parent: home,
      content_type: ContentType::LINK,
      site_templates: [@fa_template, @la_template]
    }
  )
  news = PageTemplate.create!(
    {
      name: 'News',
      description: 'View the latest news',
      uri: 'news',
      parent: home,
      content_type: ContentType::OPEN_CONTENT,
      site_templates: [@fa_template, @la_template],
      content: {body: '<p>News</p>'}
    }
  )
  news_section_1 = PageTemplate.create!(
    {
      name: 'News section 1',
      description: 'News section #1',
      uri: 'news-section-1',
      parent: news,
      content_type: ContentType::OPEN_CONTENT,
      site_templates: [@fa_template, @la_template],
      content: {body: '<p>News section 1</p>'}
    }
  )
  PageTemplate.create!(
    {
      name: 'News section 2',
      description: 'News section #2',
      uri: 'news-section-2',
      parent: news,
      content_type: ContentType::OPEN_CONTENT,
      site_templates: [@fa_template, @la_template],
      content: {body: '<p>News section 2</p>'}
    }
  )
  PageTemplate.create!(
    {
      name: 'News section 3',
      description: 'News section #3',
      uri: 'news-section-3',
      parent: news,
      content_type: ContentType::OPEN_CONTENT,
      site_templates: [@fa_template, @la_template],
      content: {body: '<p>News section 3</p>'}
    }
  )
  PageTemplate.create!(
    {
      name: 'News section 4',
      description: 'News section #4',
      uri: 'news-section-4',
      parent: news,
      content_type: ContentType::OPEN_CONTENT,
      site_templates: [@fa_template, @la_template],
      content: {body: '<p>News section 4</p>'}
    }
  )
  PageTemplate.create!(
    {
      name: 'News section 5',
      description: 'News section #5',
      uri: 'news-section-5',
      parent: news,
      content_type: ContentType::OPEN_CONTENT,
      site_templates: [@fa_template, @la_template],
      content: {body: '<p>News section 5</p>'}
    }
  )
  PageTemplate.create!(
    {
      name: 'News 1',
      description: 'News topic #1',
      uri: 'news-1',
      parent: news_section_1,
      content_type: ContentType::OPEN_CONTENT,
      site_templates: [@fa_template, @la_template]
    }
  )
  PageTemplate.create!(
    {
      name: 'News 2',
      description: 'News topic #2',
      uri: 'news-2',
      parent: news_section_1,
      content_type: ContentType::OPEN_CONTENT,
      site_templates: [@fa_template, @la_template]
    }
  )
  PageTemplate.create!(
    {
      name: 'News 3',
      description: 'News topic #3',
      uri: 'news-3',
      parent: news_section_1,
      content_type: ContentType::OPEN_CONTENT,
      site_templates: [@fa_template, @la_template]
    }
  )
  PageTemplate.create!(
    {
      name: 'News 4',
      description: 'News topic #4',
      uri: 'news-4',
      parent: news_section_1,
      content_type: ContentType::OPEN_CONTENT,
      site_templates: [@fa_template, @la_template]
    }
  )
  PageTemplate.create!(
    {
      name: 'News 5',
      description: 'News topic #5',
      uri: 'news-5',
      parent: news_section_1,
      content_type: ContentType::OPEN_CONTENT,
      site_templates: [@fa_template, @la_template]
    }
  )
  PageTemplate.create!(
    {
      name: 'News 6',
      description: 'News topic #6',
      uri: 'news-6',
      parent: news_section_1,
      content_type: ContentType::OPEN_CONTENT,
      site_templates: [@fa_template, @la_template]
    }
  )
  PageTemplate.create!(
    {
      name: 'Terms and privacy',
      description: 'Terms and privacy',
      uri: 'terms-and-privacy',
      parent: home,
      content_type: ContentType::STATIC_CONTENT,
      site_templates: [@fa_template, @la_template],
      content: {body: '<p>Terms and privacy</p>'}
    }
  )
  puts 'Template pages created successfully'
end

def create_sites

  general_site_settings = [
    {name: 'color', value: '#000000', position: 1},
    {name: 'logo_image', value: '', position: 2},
    {name: 'logo_background', value: '#000000', position: 3},
    {name: 'flag', value: '#000000', position: 4}
  ]

  @staging_demo_site = Site.new({name: 'Heroku staging for FA LSA CMS', site_template: @fa_template, slug: 'heroku-staging-for-fa-lsa-cms', site_settings_attributes: general_site_settings})
  @staging_demo_site.save!(validate: false)
  @site_two = Site.new({name: 'Site Two', site_template: @fa_template, slug: 'site-two', site_settings_attributes: general_site_settings})
  @site_two.save!(validate: false)
  @site_three = Site.new({name: 'Site Three', site_template: @la_template, slug: 'site-three', site_settings_attributes: general_site_settings})
  @site_three.save!(validate: false)
  @site_four = Site.new({name: 'Site Four', site_template: @la_template, slug: 'site-four', site_settings_attributes: general_site_settings})
  @site_four.save!(validate: false)
  @base_site = Site.new({name: 'Base site', site_template: @fa_template, slug: 'base-site', site_settings_attributes: general_site_settings})
  @base_site.save!(validate: false)
  puts 'Base site created successfully'
end

def clear
  Site.delete_all
  Page.delete_all
  Route.delete_all
  User.delete_all

  puts 'Database clear'
end

def create_base_site_routes
  routes = [
    {
      host: 'http://localhost:3000',
      site: @base_site
    }, {
      host: 'http://localhost',
      site: @base_site
    }, {
      host: 'http://0.0.0.0',
      site: @base_site
    }
  ]

  Route.create(routes)
  puts 'Routes for base site created successfully'
end

def create_heroku_staging_site_routes
  routes = [
    {
      host: 'http://fa-cms.herokuapp.com',
      site: @staging_demo_site
    }
  ]

  Route.create(routes)
  puts 'Routes for staging site created successfully'
end

def create_users
  @tiago_garcia_user = User.create(
    {
      email: 'tiago.garcia@vizzuality.com',
      name: 'Tiago Garcia'
    }
  )
  @tiago_santos_user = User.create(
    {
      email: 'tiago.santos@vizzuality.com',
      name: 'Tiago Santos'
    }
  )
  @clement_prodhomme_user = User.create(
    {
      email: 'clement.prodhomme@vizzuality.com',
      name: 'Clément Prodhomme'
    }
  )
  @thomas_maschler_user = User.create(
    {
      email: 'tmaschler@wri.org',
      name: 'Thomas Maschler'
    }
  )
  puts 'Users created successfully'
end

def create_user_sites
  user_sites = [
    {
      user: @tiago_garcia_user,
      site: @base_site
    }, {
      user: @tiago_garcia_user,
      site: @site_two
    }, {
      user: @tiago_garcia_user,
      site: @site_three
    }, {
      user: @tiago_garcia_user,
      site: @site_four
    }, {
      user: @tiago_santos_user,
      site: @staging_demo_site
    }, {
      user: @tiago_santos_user,
      site: @site_two
    }, {
      user: @tiago_santos_user,
      site: @site_three
    }, {
      user: @tiago_santos_user,
      site: @site_four
    }, {
      user: @clement_prodhomme_user,
      site: @site_two
    }, {
      user: @clement_prodhomme_user,
      site: @site_three
    }, {
      user: @clement_prodhomme_user,
      site: @site_four
    }
  ]

  # Create user site associations
  UserSiteAssociation.create(user_sites)
  puts 'User-Site associations created successfully'
end

def create_contexts
  datasets_array = [
    %w[5306fd54-df71-4e20-8b34-2ff464ab28be 3d170908-043f-49db-b26b-9e9bfaaa40ce b98de805-798b-4f93-9f90-323e7d93d94f],
    %w[b1089fc4-be58-4667-9dce-b92ac9a637b5 b9c76d91-46d6-4464-a751-ef532e043c03 03965f50-4376-4d3a-a680-683eecf07050]
  ]
  datasets_array.each_with_index do |datasets, i|
    c = Context.create!(
      {
        name: "Context #{i}",
        user_ids: [@tiago_santos_user.id, @tiago_garcia_user.id, @clement_prodhomme_user.id],
        site_ids: [@base_site.id, @staging_demo_site.id]
      })
    datasets.each{|d| c.context_datasets.build(dataset_id: d)}
    c.save
  end

  puts 'Contexts created successfully'
end

namespace :db do
  desc 'Create sample development data'
  task :sample => :environment do

    clear

    @fa_template = SiteTemplate.find_by name: 'Forest Atlas'
    @la_template = SiteTemplate.find_by name: 'Landscape Application'

    create_pages_templates
    create_sites
    create_base_site_routes
    create_heroku_staging_site_routes
    create_users
    create_user_sites
    create_contexts
  end
end
