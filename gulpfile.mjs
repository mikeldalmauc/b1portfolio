import { src, dest, series, parallel, watch } from 'gulp';
import { deleteAsync } from 'del';
import gulpElm from 'gulp-elm';
import uglify from 'gulp-uglify';
import rename from 'gulp-rename';
import { copy} from 'fs-extra';
import fs from 'fs';
import path from 'path';

// Rutas de archivos
const paths = {
  elm: 'src/Main.elm',
  assets: 'assets/**/*.{png,jpg,jpeg,svg,webp}',
  html: 'index.html',
  robots: 'robots.txt',
  sitemap: 'sitemap.xml',
  output: 'build',
  entregableAssets: 'src/Entregables/markdowns',
  h5pstandalone: 'h5p-standalone/**/*',
  highlight: 'highlight/**/*',
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

// Lee recursivamente todos los archivos de un directorio
function readDirRecursive(dir) {
  let results = [];
  const items = fs.readdirSync(dir);
  
  items.forEach((item) => {
    const itemPath = path.join(dir, item);
    const stat = fs.lstatSync(itemPath);
    
    if (stat.isDirectory()) {
      results = results.concat(readDirRecursive(itemPath));
    } else {
      results.push(itemPath);
    }
  });
  return results;
}



function entregableAssetsTask(cb) {
  try {
    // 1. Obtenemos la lista de todos los archivos de markdowns
    const allFiles = readDirRecursive(paths.entregableAssets);

    // 2. Filtramos solo los que sean imágenes
    const imageFiles = allFiles.filter(file => /\.(png|jpe?g|svg|webp)$/i.test(file));

    // 3. Copiamos cada imagen a 'assets' con el nombre base (aplanado)
    imageFiles.forEach(file => {
      const fileName = path.basename(file);
      copy(file, path.join('assets', fileName));
    });

    cb();
  } catch (error) {
    cb(error);
  }
}
// Copia los assets a la carpeta de build
// function assetsTask() {
//   return src(paths.assets, { allowEmpty: true })
//     //.pipe(debug({ title: 'Procesando:' }))
//     .pipe(dest(`${paths.output}/assets`));
// }

function assetsTask(cb) {
  copy('assets', 'build/assets')
    .then(() => cb())
    .catch(err => cb(err));
}


function h5pTask(cb){
  return src(paths.h5pstandalone)
   .pipe(dest(paths.output+ '/assets'));

}

// Copia sitemap.xml
function highlightTask() {
  return src(paths.highlight)
    .pipe(dest(paths.output + '/assets'));
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
  entregableAssetsTask,
  parallel(elmTask, assetsTask, htmlTask, robotsTask, sitemapTask, h5pTask)
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
export { dev, watchTask as watch, build, build as default, entregableAssetsTask as assets};