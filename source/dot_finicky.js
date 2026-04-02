export default {
   defaultBrowser: "Arc",
   handlers: [
      {
         match: "meet.google.com/*",
         browser: () => {
            return {
               name: "Dia",
               profile:
                  "/Users/jstegeman/Library/Application Support/Dia/User Data/Profile 1",
            };
         },
      },
   ],
};
