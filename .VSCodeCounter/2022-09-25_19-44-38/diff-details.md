# Diff Details

Date : 2022-09-25 19:44:38

Directory /Users/gaizkaurdangarin/Documents/vs_projects/errentaeusreact/app

Total : 92 files,  -215459 codes, -986 comments, -42937 blanks, all -259382 lines

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details

## Files
| filename | language | code | comment | blank | total |
| :--- | :--- | ---: | ---: | ---: | ---: |
| [.dockerignore](/.dockerignore) | Ignore | -47 | 0 | 0 | -47 |
| [Dockerfile](/Dockerfile) | Docker | -6 | -4 | -5 | -15 |
| [Gemfile](/Gemfile) | Gemfile | -29 | -28 | -27 | -84 |
| [README.md](/README.md) | Markdown | -13 | 0 | -12 | -25 |
| [config.ru](/config.ru) | Ruby | -3 | -1 | -3 | -7 |
| [config/application.rb](/config/application.rb) | Ruby | -9 | -10 | -5 | -24 |
| [config/boot.rb](/config/boot.rb) | Ruby | -3 | 0 | -2 | -5 |
| [config/cable.yml](/config/cable.yml) | YAML | -9 | 0 | -3 | -12 |
| [config/database.yml](/config/database.yml) | YAML | -13 | -9 | -4 | -26 |
| [config/environment.rb](/config/environment.rb) | Ruby | -2 | -2 | -2 | -6 |
| [config/environments/development.rb](/config/environments/development.rb) | Ruby | -27 | -23 | -21 | -71 |
| [config/environments/production.rb](/config/environments/production.rb) | Ruby | -22 | -46 | -26 | -94 |
| [config/environments/test.rb](/config/environments/test.rb) | Ruby | -20 | -24 | -17 | -61 |
| [config/importmap.rb](/config/importmap.rb) | Ruby | -5 | -1 | -2 | -8 |
| [config/initializers/assets.rb](/config/initializers/assets.rb) | Ruby | -1 | -8 | -4 | -13 |
| [config/initializers/boolean_to_i.rb](/config/initializers/boolean_to_i.rb) | Ruby | -2 | 0 | 0 | -2 |
| [config/initializers/content_security_policy.rb](/config/initializers/content_security_policy.rb) | Ruby | 0 | -29 | -6 | -35 |
| [config/initializers/devise.rb](/config/initializers/devise.rb) | Ruby | -14 | -243 | -55 | -312 |
| [config/initializers/filter_parameter_logging.rb](/config/initializers/filter_parameter_logging.rb) | Ruby | -3 | -4 | -2 | -9 |
| [config/initializers/inflections.rb](/config/initializers/inflections.rb) | Ruby | 0 | -14 | -3 | -17 |
| [config/initializers/permissions_policy.rb](/config/initializers/permissions_policy.rb) | Ruby | 0 | -11 | -1 | -12 |
| [config/initializers/rack.rb](/config/initializers/rack.rb) | Ruby | -4 | -4 | -7 | -15 |
| [config/locales/devise.en.yml](/config/locales/devise.en.yml) | YAML | -63 | -1 | -2 | -66 |
| [config/locales/en.yml](/config/locales/en.yml) | YAML | -2 | -30 | -2 | -34 |
| [config/puma.rb](/config/puma.rb) | Ruby | -8 | -28 | -8 | -44 |
| [config/routes.rb](/config/routes.rb) | Ruby | -19 | -3 | -4 | -26 |
| [config/storage.yml](/config/storage.yml) | YAML | -6 | -23 | -6 | -35 |
| [config/vite.json](/config/vite.json) | JSON | -16 | 0 | -1 | -17 |
| [db/schema.rb](/db/schema.rb) | Ruby | -66 | -11 | -6 | -83 |
| [db/seeds.rb](/db/seeds.rb) | Ruby | 0 | -7 | -1 | -8 |
| [docker/startup.sh](/docker/startup.sh) | Shell Script | -7 | -2 | -5 | -14 |
| [log/development.log](/log/development.log) | Log | -165,460 | 0 | -42,076 | -207,536 |
| [log/production.log](/log/production.log) | Log | -459 | 0 | -1 | -460 |
| [package-lock.json](/package-lock.json) | JSON | -32,289 | 0 | -1 | -32,290 |
| [package.json](/package.json) | JSON | -42 | -4 | 0 | -46 |
| [postcss.config.js](/postcss.config.js) | JavaScript | -6 | 0 | 0 | -6 |
| [public/404.html](/public/404.html) | HTML | -61 | -1 | -6 | -68 |
| [public/422.html](/public/422.html) | HTML | -61 | -1 | -6 | -68 |
| [public/500.html](/public/500.html) | HTML | -60 | -1 | -6 | -67 |
| [public/assets/.sprockets-manifest-bab345dee79f5522ef61f38334edcf9c.json](/public/assets/.sprockets-manifest-bab345dee79f5522ef61f38334edcf9c.json) | JSON | -1 | 0 | 0 | -1 |
| [public/assets/actioncable-5433453f9b6619a9de91aaab2d7fc7ff183e5260c0107cbc9a1aa0c838d9a74e.js](/public/assets/actioncable-5433453f9b6619a9de91aaab2d7fc7ff183e5260c0107cbc9a1aa0c838d9a74e.js) | JavaScript | -484 | 0 | -6 | -490 |
| [public/assets/actioncable.esm-e01089c3ec4fe7817fa9abcad06cab6bdc387f95f0ca6aab4bf7ba7537f70690.js](/public/assets/actioncable.esm-e01089c3ec4fe7817fa9abcad06cab6bdc387f95f0ca6aab4bf7ba7537f70690.js) | JavaScript | -464 | 0 | -28 | -492 |
| [public/assets/actiontext-28c61f5197c204db043317a8f8826a87ab31495b741f854d307ca36122deefce.js](/public/assets/actiontext-28c61f5197c204db043317a8f8826a87ab31495b741f854d307ca36122deefce.js) | JavaScript | -868 | 0 | -13 | -881 |
| [public/assets/activestorage-3ab61e47dd4ee2d79db525ade1dca2ede0ea2b7371fe587e408ee37b7ade265d.js](/public/assets/activestorage-3ab61e47dd4ee2d79db525ade1dca2ede0ea2b7371fe587e408ee37b7ade265d.js) | JavaScript | -823 | 0 | -1 | -824 |
| [public/assets/activestorage.esm-01f58a45d77495cdfbdfcc872902a430426c4391634ec9c3da5f69fbf8418492.js](/public/assets/activestorage.esm-01f58a45d77495cdfbdfcc872902a430426c4391634ec9c3da5f69fbf8418492.js) | JavaScript | -813 | 0 | -32 | -845 |
| [public/assets/es-module-shims-16719834c9bbcdd75f1f99da713bd0c89de488be94d4c5df594511f39cffe7c1.js](/public/assets/es-module-shims-16719834c9bbcdd75f1f99da713bd0c89de488be94d4c5df594511f39cffe7c1.js) | JavaScript | -699 | -78 | -97 | -874 |
| [public/assets/es-module-shims.min-d89e73202ec09dede55fb74115af9c5f9f2bb965433de1c2446e1faa6dac2470.js](/public/assets/es-module-shims.min-d89e73202ec09dede55fb74115af9c5f9f2bb965433de1c2446e1faa6dac2470.js) | JavaScript | -2 | -2 | -2 | -6 |
| [public/assets/manifest-b84bfa46a33d7f0dc4d2e7b8889486c9a957a5e40713d58f54be71b66954a1ff.js](/public/assets/manifest-b84bfa46a33d7f0dc4d2e7b8889486c9a957a5e40713d58f54be71b66954a1ff.js) | JavaScript | 0 | 0 | -5 | -5 |
| [public/assets/stimulus-2e76632599c700da6e187ce7b15eea7c0eace0e09f25d19e55e3b1f7c515397c.js](/public/assets/stimulus-2e76632599c700da6e187ce7b15eea7c0eace0e09f25d19e55e3b1f7c515397c.js) | JavaScript | -1,934 | -4 | -41 | -1,979 |
| [public/assets/stimulus-autoloader-c584942b568ba74879da31c7c3d51366737bacaf6fbae659383c0a5653685693.js](/public/assets/stimulus-autoloader-c584942b568ba74879da31c7c3d51366737bacaf6fbae659383c0a5653685693.js) | JavaScript | -42 | 0 | -13 | -55 |
| [public/assets/stimulus-importmap-autoloader-db2076c783bf2dbee1226e2add52fef290b5d31b5bcd1edd999ac8a6dd31c44a.js](/public/assets/stimulus-importmap-autoloader-db2076c783bf2dbee1226e2add52fef290b5d31b5bcd1edd999ac8a6dd31c44a.js) | JavaScript | -20 | -1 | -7 | -28 |
| [public/assets/stimulus-loading-1fc59770fb1654500044afd3f5f6d7d00800e5be36746d55b94a2963a7a228aa.js](/public/assets/stimulus-loading-1fc59770fb1654500044afd3f5f6d7d00800e5be36746d55b94a2963a7a228aa.js) | JavaScript | -67 | -3 | -16 | -86 |
| [public/assets/stimulus.min-b8a9738499c7a8362910cd545375417370d72a9776fb4e766df7671484e2beb7.js](/public/assets/stimulus.min-b8a9738499c7a8362910cd545375417370d72a9776fb4e766df7671484e2beb7.js) | JavaScript | -2 | -2 | -4 | -8 |
| [public/assets/tailwind-9feb1537dce11964234c16da844286da8664b423b40520df83683b2ce14c0961.css](/public/assets/tailwind-9feb1537dce11964234c16da844286da8664b423b40520df83683b2ce14c0961.css) | CSS | -1 | 0 | -1 | -2 |
| [public/assets/trix-1563ff9c10f74e143b3ded40a8458497eaf2f87a648a5cbbfebdb7dec3447a5e.js](/public/assets/trix-1563ff9c10f74e143b3ded40a8458497eaf2f87a648a5cbbfebdb7dec3447a5e.js) | JavaScript | -5,273 | -5 | -1 | -5,279 |
| [public/assets/trix-ac629f94e04ee467ab73298a3496a4dfa33ca26a132f624dd5475381bc27bdc8.css](/public/assets/trix-ac629f94e04ee467ab73298a3496a4dfa33ca26a132f624dd5475381bc27bdc8.css) | CSS | -367 | -4 | -5 | -376 |
| [public/assets/turbo-75fdf390d33bd1a4dcbba67f94d1c3ec9257fc8b8437b17a1999a61a8ebe3718.js](/public/assets/turbo-75fdf390d33bd1a4dcbba67f94d1c3ec9257fc8b8437b17a1999a61a8ebe3718.js) | JavaScript | -3,865 | 0 | -185 | -4,050 |
| [public/assets/turbo.min-e5023178542f05fc063cd1dc5865457259cc01f3fba76a28454060d33de6f429.js](/public/assets/turbo.min-e5023178542f05fc063cd1dc5865457259cc01f3fba76a28454060d33de6f429.js) | JavaScript | -22 | -2 | -4 | -28 |
| [public/vite-dev/assets/index.0f8d6f08.css](/public/vite-dev/assets/index.0f8d6f08.css) | CSS | -1 | 0 | -1 | -2 |
| [public/vite-dev/assets/index.2a00ba8d.css](/public/vite-dev/assets/index.2a00ba8d.css) | CSS | -1 | 0 | -1 | -2 |
| [public/vite-dev/assets/index.51092335.js](/public/vite-dev/assets/index.51092335.js) | JavaScript | -1 | -1 | 0 | -2 |
| [public/vite-dev/assets/vendor.15ba77bc.js](/public/vite-dev/assets/vendor.15ba77bc.js) | JavaScript | -309 | -110 | -52 | -471 |
| [public/vite-dev/manifest-assets.json](/public/vite-dev/manifest-assets.json) | JSON | -1 | 0 | 0 | -1 |
| [public/vite-dev/manifest.json](/public/vite-dev/manifest.json) | JSON | -22 | 0 | 0 | -22 |
| [public/vite/assets/index.04b9c710.css](/public/vite/assets/index.04b9c710.css) | CSS | -1 | 0 | -1 | -2 |
| [public/vite/assets/index.0f8d6f08.css](/public/vite/assets/index.0f8d6f08.css) | CSS | -1 | 0 | -1 | -2 |
| [public/vite/assets/index.253f9695.css](/public/vite/assets/index.253f9695.css) | CSS | -1 | 0 | -1 | -2 |
| [public/vite/assets/index.47c84968.js](/public/vite/assets/index.47c84968.js) | JavaScript | -1 | -1 | -1 | -3 |
| [public/vite/assets/index.bfa1e613.js](/public/vite/assets/index.bfa1e613.js) | JavaScript | -1 | -2 | 0 | -3 |
| [public/vite/assets/index.d630e4eb.css](/public/vite/assets/index.d630e4eb.css) | CSS | -1 | 0 | -1 | -2 |
| [public/vite/assets/vendor.445b307f.js](/public/vite/assets/vendor.445b307f.js) | JavaScript | -40 | -79 | -2 | -121 |
| [public/vite/assets/vendor.ff165755.js](/public/vite/assets/vendor.ff165755.js) | JavaScript | -211 | -90 | -5 | -306 |
| [public/vite/manifest-assets.json](/public/vite/manifest-assets.json) | JSON | -1 | 0 | 0 | -1 |
| [public/vite/manifest.json](/public/vite/manifest.json) | JSON | -22 | 0 | 0 | -22 |
| [tailwind.config.js](/tailwind.config.js) | JavaScript | -17 | 0 | -2 | -19 |
| [test/application_system_test_case.rb](/test/application_system_test_case.rb) | Ruby | -4 | 0 | -2 | -6 |
| [test/channels/application_cable/connection_test.rb](/test/channels/application_cable/connection_test.rb) | Ruby | -3 | -7 | -2 | -12 |
| [test/controllers/appointments_controller_test.rb](/test/controllers/appointments_controller_test.rb) | Ruby | -38 | 0 | -11 | -49 |
| [test/controllers/home_controller_test.rb](/test/controllers/home_controller_test.rb) | Ruby | -7 | 0 | -2 | -9 |
| [test/controllers/tax_incomes_controller_test.rb](/test/controllers/tax_incomes_controller_test.rb) | Ruby | -38 | 0 | -11 | -49 |
| [test/fixtures/appointments.yml](/test/fixtures/appointments.yml) | YAML | -8 | -1 | -3 | -12 |
| [test/fixtures/tax_incomes.yml](/test/fixtures/tax_incomes.yml) | YAML | -12 | -1 | -3 | -16 |
| [test/fixtures/users.yml](/test/fixtures/users.yml) | YAML | -2 | -8 | -2 | -12 |
| [test/models/appointment_test.rb](/test/models/appointment_test.rb) | Ruby | -3 | -3 | -2 | -8 |
| [test/models/tax_income_test.rb](/test/models/tax_income_test.rb) | Ruby | -3 | -3 | -2 | -8 |
| [test/models/user_test.rb](/test/models/user_test.rb) | Ruby | -3 | -3 | -2 | -8 |
| [test/system/appointments_test.rb](/test/system/appointments_test.rb) | Ruby | -35 | 0 | -11 | -46 |
| [test/system/tax_incomes_test.rb](/test/system/tax_incomes_test.rb) | Ruby | -39 | 0 | -11 | -50 |
| [test/test_helper.rb](/test/test_helper.rb) | Ruby | -7 | -3 | -4 | -14 |
| [tmp/cache/vite/last-build-development.json](/tmp/cache/vite/last-build-development.json) | JSON | -6 | 0 | 0 | -6 |
| [tmp/cache/vite/last-build-production.json](/tmp/cache/vite/last-build-production.json) | JSON | -6 | 0 | 0 | -6 |
| [vite.config.ts](/vite.config.ts) | TypeScript | -9 | 0 | -2 | -11 |

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details