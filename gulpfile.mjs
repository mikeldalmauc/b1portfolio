import { src, dest, series, parallel, watch } from 'gulp';
import exec from 'gulp-exec';
import { deleteAsync } from 'del';
import gulpElm from 'gulp-elm';
import uglify from 'gulp-uglify';
import rename from 'gulp-rename';

// Rutas de archivos
const paths = {
  elm: 'src/Main.elm',
  assets: 'assets/**',
  html: 'index.html',
  robots: 'robots.txt',
  sitemap: 'sitemap.xml',
  output: 'build'
};

// Limpia la carpeta de salida
function clean() {
  return deleteAsync([paths.output]);
}

function elmTask() {
  return src(paths.elm)
    .pipe(gulpElm.bundle('main.js', { optimize: true }))
    .pipe(uglify({
      compress: {
        pure_funcs: [
          'F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8', 'F9',
          'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'A9'
        ],
        pure_getters: true,
        keep_fargs: false,
        unsafe_comps: true,
        unsafe: true
      },
      mangle: true
    }))
    .pipe(rename('main.min.js'))
    .pipe(dest(paths.output));
}


// Copia los assets a la carpeta de build
function assetsTask() {
  return src(paths.assets)
    .pipe(dest(`${paths.output}/assets`));
}

// Copia el HTML
function htmlTask() {
  return src(paths.html)
    .pipe(dest(paths.output));
}

// Copia robots.txt
function robotsTask() {
  return src(paths.robots)
    .pipe(dest(paths.output));
}

// Copia sitemap.xml
function sitemapTask() {
  return src(paths.sitemap)
    .pipe(dest(paths.output));
}

// Construye todo en paralelo (tras limpiar la carpeta)
const build = series(
  clean,
  parallel( elmTask, assetsTask, htmlTask, robotsTask, sitemapTask)
);

// (Opcional) Tarea para vigilar archivos y recompilar al vuelo
function watchTask() {
  watch(paths.elm,  elmTask);
  watch(paths.assets, assetsTask);
  watch(paths.html, htmlTask);
  watch(paths.robots, robotsTask);
  watch(paths.sitemap, sitemapTask);
}

const dev = series(build, watchTask);

// Exporta las tareas
export { dev, watchTask as watch, build, build as default };