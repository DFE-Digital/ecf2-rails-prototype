namespace :gias do
  desc "Import schools data from Get Information About Schools"
  task import: :environment do
    logger = Logger.new($stdout)
    logger.info "Importing GIAS schools data, this may take a couple minutes..."
    GIAS::SchoolImporter.new.import_and_update_school_data_from_GIAS
    logger.info "GIAS schools data import complete!"
  end
end
