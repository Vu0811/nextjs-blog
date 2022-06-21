FROM node:10 AS ui-build
WORKDIR /usr/src/app
COPY nextjs-blog/ ./nextjs-blog/
RUN cd nextjs-blog && npm install && npm run build

FROM node:10 AS server-build
WORKDIR /root/
COPY --from=ui-build /usr/src/app/nextjs-blog/out ./nextjs-blog/out
COPY api/package*.json ./api/
RUN cd api && npm install
COPY api/server.js ./api/

EXPOSE 3080

CMD ["node", "./api/server.js"]