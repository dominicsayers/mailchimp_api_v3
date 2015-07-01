guard :rubocop do
  watch(/.+\.rb$/)
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end

guard(
  :rspec,
  all_after_pass: true,
  all_on_start: true,
  cmd: 'NO_SIMPLECOV=true bundle exec rspec --fail-fast --format documentation'
) do
  watch(%r{spec/.+_spec\.rb$})
  watch(%r{lib/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb') { 'spec' }
  watch(%r{^spec/support/.+\.rb$}) { 'spec' }
end
