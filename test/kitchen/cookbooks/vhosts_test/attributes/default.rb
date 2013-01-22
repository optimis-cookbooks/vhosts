override['apache2']['vhosts'] = [
  { 
    "name" => 'test.optimispt.com',
    "title" => 'Test',
    "domain" => 'optimispt',
    "aliases" => [ 'content-staging.optimispt.com' ],
    "environment" => 'production'
  }
]
