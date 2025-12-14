export default {
  defaultBrowser: "Arc",
  handlers: [
    {
      match: "meet.google.com/*",
      browser: () => {
        return {
          name: "Arc",
          profile: "Work",
        };
      }, 
    },
    {
      match: "news.google.com/*",
      browser: () => {
        return {
          name: "Dia",
          profile: "Personal",
        };
      }, 
    }
  ]
};