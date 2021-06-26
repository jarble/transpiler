var APP_PREFIX = 'ApplicationName_'     // Identifier for this app (this needs to be consistent across every cache update)
var VERSION = 'version_01'              // Version of the off-line cache (change this value everytime you want to update cache)
var CACHE_NAME = APP_PREFIX + VERSION
var URLS = [                            // Add URL you want to cache in this list.
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/java_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/alloy_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/tex_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/kotlin_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/minizinc_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/tptp_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/rust_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/scala_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/cpp_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/ada_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/vhdl_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/go_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/javascript_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/python_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/webassembly_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/core_logic_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/delphi_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/fortran_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/standard_ml_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/thrift_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/protobuf_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/mysql_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/glsl_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/r_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/pseudocode_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/swift_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/octave_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/typescript_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/smt_lib_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/wolfram_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/erlang_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/mathematical_notation_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/maxima_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/english_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/julia_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/perl_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/prolog_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/mercury_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/coq_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/lean_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/pddl_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/clojure_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/common_lisp_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/emacs_lisp_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/racket_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/clips_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/kif_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/jison_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/ometa_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/racc_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/ohm_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/marpa_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/nearley_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/pegjs_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/picat_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/regex_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/antlr_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/txl_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/haskell_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/futhark_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/ats_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/haxe_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/php_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/hack_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/lua_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/vba_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/vb_net_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/ruby_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/c_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/c_sharp_parser.js',
'https://jarble.github.io/transpiler/javascript/js_transpiler/jison_parsers/transpiler.js',
'https://jarble.github.io/transpiler/',                     // If you have separate JS/CSS files,
'https://jarble.github.io/transpiler/javascript/js_transpiler/test_parser.html'            // add path to those files here
]

// Respond with cached resources
self.addEventListener('fetch', function (e) {
  //console.log('fetch request : ' + e.request.url)
  e.respondWith(
    caches.match(e.request).then(function (request) {
      if (request) { // if cache is available, respond with cache
        //console.log('responding with cache : ' + e.request.url)
        return request
      } else {       // if there are no cache, try fetching request
        //console.log('file is not cached, fetching : ' + e.request.url)
        return fetch(e.request)
      }

      // You can omit if/else for console.log & put one line below like this too.
      // return request || fetch(e.request)
    })
  )
})

// Cache resources
self.addEventListener('install', function (e) {
  e.waitUntil(
    caches.open(CACHE_NAME).then(function (cache) {
      //console.log('installing cache : ' + CACHE_NAME)
      return cache.addAll(URLS)
    })
  )
})

// Delete outdated caches
self.addEventListener('activate', function (e) {
  e.waitUntil(
    caches.keys().then(function (keyList) {
      // `keyList` contains all cache names under your username.github.io
      // filter out ones that has this app prefix to create white list
      var cacheWhitelist = keyList.filter(function (key) {
        return key.indexOf(APP_PREFIX)
      })
      // add current cache name to white list
      cacheWhitelist.push(CACHE_NAME)

      return Promise.all(keyList.map(function (key, i) {
        if (cacheWhitelist.indexOf(key) === -1) {
          //console.log('deleting cache : ' + keyList[i] )
          return caches.delete(keyList[i])
        }
      }))
    })
  )
})
