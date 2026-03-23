export default {
   defaultBrowser: "Zen",
   handlers: [
      {
         match: "meet.google.com/*",
         browser: () => {
            return {
               name: "Dia",
               profile: "Work",
            };
         },
      },
   ],
};
