module ModelSpecHelper
  shared_context 'default_resources' do
    let(:project) { FactoryGirl.create(:project) }
    let(:cloud) { FactoryGirl.create(:cloud, project: project) }
    let(:base_image) { cloud.base_images.first || FactoryGirl.create(:base_image, cloud: cloud) }
    let(:blueprint) { FactoryGirl.create(:blueprint, project: project) }
    let(:pattern) { FactoryGirl.create(:pattern, :platform, project: project) }
    let(:blueprint_history) { FactoryGirl.create(:blueprint_history, blueprint: blueprint) }
    let(:pattern_snapshot) { FactoryGirl.create(:pattern_snapshot, images: FactoryGirl.create_list(:image, 1, cloud: cloud, status: :CREATE_COMPLETE)) }
    let(:blueprint_pattern) do
      blueprint.blueprint_patterns << FactoryGirl.create(:blueprint_pattern, blueprint: blueprint, pattern: pattern)
      blueprint.blueprint_patterns.first
    end
    let(:image) { pattern_snapshot.images.first }
    let(:system) { FactoryGirl.create(:system, project: project) }
    let(:environment) do
      environment = FactoryGirl.create(:environment, system: system, blueprint_history: blueprint_history, candidates_attributes: [FactoryGirl.attributes_for(:candidate, cloud: cloud)])
      system.update_columns(primary_environment_id: environment.id)
      environment
    end
    let(:stack) { environment.stacks.first }
    let(:candidate) { environment.candidates.first }
    let(:application) { FactoryGirl.create(:application, system: system) }
    let(:application_history) { FactoryGirl.create(:application_history, application: application) }

    let(:role) { FactoryGirl.create(:role, project: project) }
  end
end
