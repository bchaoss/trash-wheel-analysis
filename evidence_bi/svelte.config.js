import adapter from '@sveltejs/adapter-static';

export default {
  kit: {
    adapter: adapter(),
    prerender: {
      handleHttpError: ({ path, status, referrer, referenceType }) => {
        console.warn(`Prerender warning: ${status} at ${path}`);
        return true; 
      }
    }
  }
};